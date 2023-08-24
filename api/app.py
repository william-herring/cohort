from flask import Flask, request, abort, jsonify
import os
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity

app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY')
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET')
app.config['SQLALCHEMY_DATABASE_URI'] = os.getenv('DATABASE_URI')
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)
migrate = Migrate(app, db)
jwt = JWTManager(app)

from models import *

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

@app.route('/api/join-school', methods=['POST'])
@jwt_required()
def join_school():
    user = User.query.get(get_jwt_identity())
    school_code = request.json.get('code')

    school = School.query.filter_by(invite_code=school_code).first()
    if school is None:
        abort(404)

    school.people.append(user)
    db.session.add(school)
    db.session.commit()

    return jsonify({ 'id': school.id, 'name': school.name }), 200


@app.route('/api/create-school', methods=['POST'])
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

@app.route('/api/create-class', methods=['POST'])
@jwt_required()
def create_class():
    user = User.query.get(get_jwt_identity())
    if user.role != 'Educator':
        abort(403)

    title = request.json.get('title')
    class_code = request.json.get('title')
    people = [user]
    class_obj = Class(
        name=title,
        class_code=class_code,
        people=people
    )
    db.session.add(class_obj)
    db.session.commit()

    return jsonify({ 'class_code': class_obj.class_code }), 201

@app.route('/api/get-classes', methods=['POST'])
@jwt_required()
def get_classes():
    user = User.query.get(get_jwt_identity())
    classes_list = []
    for c in user.classes:
        classes_list.append({
            'id': c.id,
            'class_code': c.class_code,
            'name': c.name
        })

    return jsonify({ 'classes': classes_list }), 200

@app.route('/api/create-post', methods=['POST'])
@jwt_required()
def create_post():
    user = User.query.get(get_jwt_identity())
    if user.role != 'Educator':
        abort(403)

    attachments = request.json.get('attachments')
    if attachments is not None:
        attachments = []
        for i in attachments:
            a = Attachment(
                resource_url=i
            )
            db.session.add(Attachment)
            db.session.commit()
            attachments.append(a)

    title = request.json.get('title')
    body = request.json.get('body')
    tag = request.json.get('tag')
    is_lesson_plan = request.json.get('is_lesson_plan')
    class_id = Class.query.filter(class_code=request.json.get('class')).first().id
    class_obj = Post(
        title=title,
        body=body,
        tag=tag,
        class_id=class_id,
        is_lesson_plan=is_lesson_plan,
        attachments=attachments
    )
    db.session.add(class_obj)
    db.session.commit()

    return 201
