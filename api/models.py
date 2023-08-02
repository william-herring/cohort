from app import db


class Person(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    user_id = db.Column(db.String(10), unique=True, nullable=True)
    role = db.Column(db.String(20), nullable=False, default='Student')
    avatar = db.Column(db.String(300), nullable=False)
    school = db.Column(db.Integer, db.ForeignKey('school.id'))

    def __repr__(self):
        return f'<Person {self.user_id}>'

class School(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    students = db.relationship('Person', backref='school')
    staff = db.relationship('Person', backref='school')

    def __repr__(self):
        return f'<Result {self.event} Person {self.person_id}>'
