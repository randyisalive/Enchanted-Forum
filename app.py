# save this as app.py
from flask import Flask, redirect, render_template, request, session, url_for, flash
import re
from db import db_connection

app = Flask(__name__)
app.secret_key = '1'

@app.route("/")
def index():
    conn = db_connection()
    cur = conn.cursor()
    sql = "SELECT id, title, body, likes, comments, users_id, username FROM posts ORDER BY id"
    cur.execute(sql)
    forum = cur.fetchall()
    cur.close()
    conn.close()
    return render_template('index.html', forum=forum)

@app.route("/login", methods=['POST','GET'])
def login():
    if request.method == "POST":
        username = request.form['username']
        password = request.form['password']
        
        conn = db_connection()
        cur = conn.cursor()
        sql = """
            SELECT id, email, name, age, user_password
            FROM users
            WHERE name = '%s' AND user_password = '%s'
        """ % (username, password)
        cur.execute(sql)
        user = cur.fetchone()
        error = ''
        if user is None:
            error = 'Invalid email address or password!!'
        else:
            session.clear()
            session['name'] = user[2]
            return redirect(url_for('index'))
        
        flash(error)
        cur.close()
        conn.close()
        
    return render_template('login.html')

@app.route('/logout')
def logout():
    """ function to do logout """
    session.clear()  # clear all sessions
    return redirect(url_for('login'))


@app.route('/signup', methods=['POST', 'GET'])
def signup():
    msg = ''
    if request.method == 'POST'and 'username' in request.form and 'password' in request.form and 'email' in request.form:
        username = request.form['username']
        password = request.form['password']
        email = request.form['email']
        age = request.form['age']
        conn = db_connection()
        cur = conn.cursor()
        cur.execute('SELECT * FROM users WHERE name = %s', (username))
        account = cur.fetchall()
        if account:
            msg = 'Account already exists!'
        elif not re.match(r'[^@]+@[^@]+\.[^@]+', email):
            msg = 'Invalid email address !'
        elif not re.match(r'[A-Za-z0-9]+', username):
            msg = 'Username must contain only characters and numbers !'
        elif not username or not password or not email:
            msg = 'Please fill out the form !'
        else:
            # Account doesnt exists and the form data is valid, now insert new account into accounts table
            cur.execute('INSERT INTO users (name,user_password,email, age) VALUES ( %s, %s,%s, %s)', (username, password,email, age))
            conn.commit()
            cur.close()
            conn.close()
            msg = 'You have successfully registered!'
            flash(msg)
            return redirect(url_for('login'))
    elif request.method == 'POST':
        msg = 'Please fill out the form !'
    return render_template('signup.html', msg=msg)

@app.route('/create', methods=['POST', 'GET'])
def create():
    if not session :
        return redirect(url_for('login'))
    if request.method == 'POST':
        title = request.form['title']
        body = request.form['body']
        id = session.get('id')
        username = session.get('name')
        conn = db_connection()
        cur = conn.cursor()

        sql = "INSERT INTO posts (title,body,users_id,username) VALUES ('%s', '%s','%s','%s') " % (title,body,id, username)

        cur.execute(sql)
        conn.commit()
        cur.close()
        conn.close()
        return redirect(url_for('index'))   
    return render_template('create.html')


@app.route('/signup/TermOfService')
def tos():
    msg = ''
    db = db_connection()
    cursor = db.cursor()
    sql = "SELECT tos FROM tos"
    cursor.execute(sql)
    text = cursor.fetchone()
    if text is None:
        msg1 = 'Term of Service not yet made'
        return msg1
    else:
        msg1 = 'Hello'
        return render_template('TermOfService.html', msg1=msg1, text=text)
    return render_template('signup.html', msg1=msg1, text=text)


@app.route('/index/<int:id>', methods=['GET'])
def read(id):
    conn = db_connection()
    cur = conn.cursor()
    sql = """ 
        SELECT p.title, p.body, usr.name, usr.email
        FROM posts p
        JOIN users usr ON usr.id = p.users_id
        WHERE p.id = %s
        """ % id
    cur.execute(sql)
    post = cur.fetchone()
    cur.close()
    conn.close()
    return render_template('detail.html', post=post)

        


def save_data(data):
    # data is a dict
    # notice by checking the existence of 'id', we could do update and insert
    if data:
        title = data.get('title')
        body = data.get('body')

        sql = """
            INSERT INTO posts (title,body) VALUES ('%s','%s')
        """ % (title,body)

        if data.get('id'):  # if there is id in the data dict, UPDATE
            posts_id = data.get('id')
            sql = """
                UPDATE posts SET title = '%s' WHERE id = %d
            """ % (title, posts_id)

        db = db_connection()
        cur = db.cursor()
        cur.execute(sql)
        db.commit()
        cur.close()
        db.close()


