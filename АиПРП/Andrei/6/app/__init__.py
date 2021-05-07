from flask import Flask
from flask_sqlalchemy import SQLAlchemy

database = 'car_db'
mysqluser = 'root'
password = 'password'
ip = 'localhost'
db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config['SECRET_KEY'] = 'secret'
    app.config['SQLALCHEMY_DATABASE_URI'] = f"mysql+pymysql://{mysqluser}:{password}@{ip}/{database}"
    db.init_app(app)

    return app

app = create_app()

from app import views