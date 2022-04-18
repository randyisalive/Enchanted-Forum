# save this as app.py
from flask import Flask, redirect, render_template, request, session, url_for, flash
import re
from db import db_connection

app = Flask(__name__)
app.secret_key = 'THISISMYSECRETKEY'

@app.route("/")
def index():
    return render_template('index.html')

@app.route("/login", methods=['POST','GET'])
def login():
    if request.method == "POST":
        email = request.form['email']
        password = request.form['password']
        
        conn = db_connection()
        cur = conn.cursor()
        sql = """
            SELECT id, email, name, age, user_password
            FROM users
            WHERE email = '%s' AND user_password = '%s'
        """ % (email, password)
        cur.execute(sql)
        user = cur.fetchone()
        error = ''
        if user is None:
            error = 'Invalid email address or password!!'
        else:
            session.clear()
            session['username'] = user[2]
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
            msg = 'You have successfully registered!'
            flash(msg)
            return redirect(url_for('login'))
    elif request.method == 'POST':
        msg = 'Please fill out the form !'
    return render_template('signup.html', msg=msg)

