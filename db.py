import pymysql

def db_connection():
    conn = pymysql.connect(
        host='localhost',
        port=3306,
        database='flask_forum',
        user='root',
        password=''
    )
    return conn