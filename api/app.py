from flask import Flask, request, abort, jsonify
import os
from flask_migrate import Migrate
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
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
    class_code = request.json.get('class_code')
    classroom = request.json.get('classroom')
    students = request.json.get('students')
    people = [user]
    for s in students:
        try:
            people.append(User.query.filter_by(user_id=s).first())
        except:
            abort(404)

    class_obj = Class(
        name=title,
        class_code=class_code,
        classroom=classroom,
        people=people
    )
    db.session.add(class_obj)
    db.session.commit()

    print(class_obj.people)
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

@app.route('/api/get-class', methods=['POST'])
@jwt_required()
def get_class():
    user = User.query.get(get_jwt_identity())
    for c in user.classes:
        if c.class_code == request.json.get('class_code'):
            students = []
            teachers = []
            for p in c.people:
                if user.role == 'Educator':
                    students.append({ 'user_id': p.user_id, 'name': p.name, 'email': p.email, 'avatar': p.avatar }) if p.role == 'Student' else teachers.append({ 'user_id': p.user_id, 'name': p.name, 'email': p.email, 'avatar': p.avatar })
                else:
                    students.append({ 'user_id': p.user_id, 'name': p.name }) if p.role == 'Student' else teachers.append({ 'user_id': p.user_id, 'name': p.name, 'email': p.email, 'avatar': p.avatar })

            return jsonify({ 'class_code': c.class_code, 'name': c.name, 'classroom': c.classroom, 'people': {
                'students': students,
                'teachers': teachers
            } }), 200

    return abort(404)

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

    return jsonify({ 'CREATED': 'Post created' }), 201

@app.route('/api/create-schedule', methods=['POST'])
@jwt_required()
def create_schedule():
    user = User.query.get(get_jwt_identity())
    if user.role != 'Educator':
        abort(403)

    school = user.school_id

    schema_csv = request.json.get('schema').splitlines()
    schedules_csv = request.json.get('schedules')

    schema_data = []
    for row in schema_csv:
        schema_data.append(row.split(','))

    schema = ScheduleSchema(
        school_id=school,
        week_cycle=int(schema_csv[0].split(',')[1]),
        period1=datetime.time(hour=int(schema_csv[1].split(',')[1].split(':')[0]), minute=int(schema_csv[1].split(',')[1].split(':')[1])).strftime('1900-01-01 %H:%M:%S.%f'),
        period2=datetime.time(hour=int(schema_csv[2].split(',')[1].split(':')[0]), minute=int(schema_csv[2].split(',')[1].split(':')[1])).strftime('1900-01-01 %H:%M:%S.%f'),
        period3=datetime.time(hour=int(schema_csv[3].split(',')[1].split(':')[0]), minute=int(schema_csv[3].split(',')[1].split(':')[1])).strftime('1900-01-01 %H:%M:%S.%f'),
        period4=datetime.time(hour=int(schema_csv[4].split(',')[1].split(':')[0]), minute=int(schema_csv[4].split(',')[1].split(':')[1])).strftime('1900-01-01 %H:%M:%S.%f'),
        period5=datetime.time(hour=int(schema_csv[5].split(',')[1].split(':')[0]), minute=int(schema_csv[5].split(',')[1].split(':')[1])).strftime('1900-01-01 %H:%M:%S.%f'),
    )

    print(schedules_csv[0])
    # Generates schedule codes for each class.
    # Schedule codes look like this: 4-1-2|3-5-N-END-N-2|3-4-1-1-END
    schedules_data = {}
    for table in schedules_csv:
        for i, row in enumerate(table.splitlines()):
            if i > 0:
                data = row.split(',')
                print(row)
                if data[0] in schedules_data.keys():
                    code = '-'
                    for d in range(6):
                        if data[d] == 'None':
                            code += 'N-'
                        else:
                            code += data[d].strip().replace(',', '|') + '-'
                    schedules_data[data[0]] = schedules_data[data[0]] + code + 'END'
                else:
                    code = ''
                    for d in range(6):
                        if data[d] == 'None':
                            code += 'N-'
                        else:
                            code += data[d].strip().replace(',', '|') + '-'
                    schedules_data[data[0]] = code + 'END'

    db.session.add(schema)
    print(schedules_data)

    for c in schedules_data.keys():
        class_obj = Class.query.filter_by(class_code=c).first()
        class_obj.schedule_code = schedules_data[c]
        db.session.add(class_obj)
        db.session.commit()

    db.session.commit()

    return jsonify({ 'OK': 'Schedule generated' }), 201

@app.route('/api/get-schedule', methods=['GET'])
@jwt_required()
def get_schedule():
    user = User.query.get(get_jwt_identity())
    schema = ScheduleSchema.query.filter_by(school_id=user.school_id).first()

    period_time_mapping = {
        1: datetime.datetime.timestamp(schema.period1),
        2: datetime.datetime.timestamp(schema.period2),
        3: datetime.datetime.timestamp(schema.period3),
        4: datetime.datetime.timestamp(schema.period4),
        5: datetime.datetime.timestamp(schema.period5),
    }
    get_period_time = lambda p : period_time_mapping[int(p)] if '|' not in p else [period_time_mapping[int(p.split('|')[0])], period_time_mapping[int(p.split('|')[1])]],

    data = {}

    for c in User.classes:
        weeks = c.schedule_code.split('END')
        for i in range(schema.week_cycle):
            week = weeks[i].split('-')
            data[f'week{i+1}'] = {
                'Monday': get_period_time(week[1]),
                'Tuesday':  get_period_time(week[2]),
                'Wednesday': get_period_time(week[3]),
                'Thursday': get_period_time(week[4]),
                'Friday': get_period_time(week[5])
            }

    return jsonify(data), 200
