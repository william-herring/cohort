from flask import Flask, render_template, request, session
import os
import requests
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY')
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URI')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)

from models import Person

@app.route('/add-person', methods=['POST'])
def index():
    pass
