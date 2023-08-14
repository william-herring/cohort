import random
import string

from app import db
from passlib.apps import custom_app_context as pwd_context


class User(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    password_hash = db.Column(db.String(128))
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), nullable=False)
    user_id = db.Column(db.String(10), unique=True)
    role = db.Column(db.String(20), default='Student')
    avatar = db.Column(db.String(300))
    school_id = db.Column(db.Integer, db.ForeignKey('school.id'))

    def hash_password(self, password):
        self.password_hash = pwd_context.encrypt(password)

    def verify_password(self, password):
        return pwd_context.verify(password, self.password_hash)

    def __repr__(self):
        return f'<Person {self.user_id}>'

class School(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    people = db.relationship('User', backref='school')
    invite_code = db.Column(db.String(6), unique=True)

    def generate_invite_code(self):
        code = ''.join(random.choices(string.ascii_uppercase, k=6))
        while School.query.filter(invite_code=code).first() is not None:
            code = ''.join(random.choices(string.ascii_uppercase, k=6))
        self.invite_code = code
