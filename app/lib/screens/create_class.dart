import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../main.dart';
import '../models/user.dart';
import '../widgets/modals/join_school.dart';

class CreateClassScreen extends StatefulWidget {
  User user;
  CreateClassScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<CreateClassScreen> createState() => _CreateClassScreenState(user);
}

class _CreateClassScreenState extends State<CreateClassScreen> {
  User user;
  String title = '';
  String classCode = '';
  List<String> students = [];
  final _formKey = GlobalKey<FormState>();

  _CreateClassScreenState(this.user);

  Future<void> createClass() async {
    _formKey.currentState?.validate();
    Response response = await post(Uri.parse('${apiBaseUrl}create-class'), headers: {'Content-Type': 'application/json', 'Authorization': "Bearer ${prefs.get('token')}"}, body: jsonEncode({
      'title': title,
      'class_code': classCode,
      'students': students,
    }));

    print(response.body);
    if (response.statusCode == 201) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    currentUser = user;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Create a Class', style: TextStyle(
              fontWeight: FontWeight.bold
          )),
          actions: [
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/profile'),
              child: Container(
                margin: const EdgeInsets.only(right: 15.0),
                child: user.avatar != null? CircleAvatar(
                  radius: 20.00,
                  backgroundImage: NetworkImage(user.avatar.toString()),
                ) :
                const CircleAvatar(
                  backgroundColor: Color.fromRGBO(224, 70, 70, 1),
                  radius: 20.00,
                  child: Text('WH', style: TextStyle(color: Colors.white)),
                ),
              ),
            )
          ],
          leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(22.0, 12.0, 22.0, 8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(123, 88, 198, 1))
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(123, 88, 198, 1))
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(123, 88, 198, 1),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field must not be empty';
                    }
                    setState(() {
                      title = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Class code',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(123, 88, 198, 1))
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(123, 88, 198, 1))
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(123, 88, 198, 1),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field must not be empty';
                    }
                    if (value.length > 10) {
                      return 'Class code cannot be longer than 10 characters';
                    }
                    setState(() {
                      classCode = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Students',
                    hintText: 'Separate with commas (e.g. HERR80, WANG21)',
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(123, 88, 198, 1))
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromRGBO(123, 88, 198, 1))
                    ),
                    labelStyle: TextStyle(
                      color: Color.fromRGBO(123, 88, 198, 1),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Field must not be empty';
                    }
                    List<String> studentList = [];
                    for (String id in value.replaceAll(' ', '').split(',')) {
                      studentList.add(id);
                    }
                    setState(() {
                      students = studentList;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(onPressed: createClass,
                  style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromRGBO(123, 88, 198, 1))),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Create', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
