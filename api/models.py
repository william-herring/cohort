import datetime
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
    classes = db.relationship('Class', backref='user')
    replies = db.relationship('Reply', backref='user')

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

class Class(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    class_code = db.Column(db.String(10), nullable=False)
    name = db.Column(db.String(100), nullable=False)
    people = db.relationship('User', backref='class')
    posts = db.relationship('Post', backref='class')

class Post(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    class_id = db.Column(db.Integer, db.ForeignKey('class.id'))
    created = db.Column(db.DateTime, default=datetime.datetime.now())
    title = db.Column(db.String(100), nullable=False)
    body = db.Column(db.String(500))
    tag = db.Column(db.String(20), default='General')
    is_lesson_plan = db.Column(db.Boolean, default=False)
    replies = db.relationship('Reply', backref='post')
    attachments = db.relationship('Attachment', backref='post')

class Reply(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    post_id = db.Column(db.Integer, db.ForeignKey('class.id'))
    author_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    attachments = db.relationship('Attachment', backref='reply')

class Attachment(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    post_id = db.Column(db.Integer, db.ForeignKey('post.id'))
    reply_id = db.Column(db.Integer, db.ForeignKey('reply.id'))
    resource_url = db.Column(db.String(250), nullable=False)
