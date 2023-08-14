import random
from flask import Flask, request, abort, jsonify
import os
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity

app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY')
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET')
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URI')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
jwt = JWTManager(app)

from models import User, School

with app.app_context():
    db.create_all()

@app.route('/api/create-user', methods=['POST'])
def create_user():
    name = request.json.get('name')
    email = request.json.get('email')
    password = request.json.get('password')
    role = request.json.get('role')
    avatar = request.json.get('avatar')

    if role not in ['Student', 'Educator', 'Parent']:
        abort(400)
    if name is None or password is None or email is None:
        abort(400)
    if User.query.filter_by(email=email).first() is not None:
        abort(400)

    surname = name.upper().split()[1] if ' ' in name else name.upper()
    user_id = (surname[:4] if len(surname) > 4 else surname) + str(random.randint(10, 99))
    while User.query.filter_by(user_id=user_id).first() is not None:
        user_id = (surname[:4] if len(surname) > 4 else surname) + str(random.randint(10, 99))

    user = User(name=name, email=email, user_id=user_id, role=role, avatar=avatar if avatar is not None else f'https://ui-avatars.com/api/?name={name}&background=E04646&color=fff')
    user.hash_password(password)
    db.session.add(user)
    db.session.commit()

    token = create_access_token(identity=user.id)

    return jsonify({ 'token': token, 'user_id': user.user_id }), 201

@app.route('/api/token', methods=['POST'])
def get_token():
    user_id = request.json.get('user_id')
    password = request.json.get('password')

    user = User.query.filter_by(user_id=user_id).first()
    if user is None:
        abort(400)

    if user.verify_password(password):
        return jsonify({ 'token': create_access_token(identity=user.id) }), 200

    abort(400)

@app.route('/api/get-user', methods=['GET'])
@jwt_required()
def get_user():
    user = User.query.get(get_jwt_identity())
    return jsonify({ 'user_id': user.user_id, 'name': user.name, 'email': user.email, 'avatar': user.avatar, 'role': user.role }), 200

@app.route('/api/get-user', methods=['POST'])
@jwt_required()
def create_school():
    user = User.query.get(get_jwt_identity())
    if user.role != 'Educator':
        abort(403)

    title = request.json.get('title')
    school = School(
        name=title,
        people=[user]
    )
    school.generate_invite_code()
    db.session.add(school)
    db.session.commit()


    return jsonify({ 'invite_code': school.invite_code }), 201


@app.route('/api/join-school', methods=['POST'])
@jwt_required()
def join_school():
    user = User.query.get(get_jwt_identity())
    school_code = request.json.get('code')

    school = School.query.filter(invite_code=school_code).first()
    if school is None:
        abort(404)

    school.people.append(user)
    db.session.add(school)
    db.session.commit()

    return jsonify({ 'id': school.id, 'name': school.name }), 201
