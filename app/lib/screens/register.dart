import 'dart:convert';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:app/constants.dart';
import '../models/user.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name = '';
  String password = '';
  String role = '';
  String email = '';
  String avatar = '';
  final _formKey = GlobalKey<FormState>();

  handleSubmit() async {
    _formKey.currentState?.validate();
    Response response = await post(Uri.parse('${apiBaseUrl}create-user'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({
      'name': name,
      'password': password,
      'role': role,
      'email': email,
      'avatar': avatar
    }));

    await prefs.setString('token', jsonDecode(response.body)['token']);

    currentUser = User(
      jsonDecode(response.body)['user_id'],
      role,
      name,
      email,
      avatar
    );

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(123, 88, 198, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leadingWidth: 130,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Image(image: AssetImage('assets/images/logo.png')),
        ),
        title: const Text('Register', style: TextStyle(
            fontWeight: FontWeight.bold
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(onPressed: () => Navigator.pop(context),
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((
                      states) => Colors.white)),
              child: const Text("Log in", style: TextStyle(
                  color: Color.fromRGBO(123, 88, 198, 1),
                  fontWeight: FontWeight.w700)),
            ),
          )
        ],
      ),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20.00),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0)
                ),
                height: 450,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Create an Account', style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.00,
                          color: Color.fromRGBO(123, 88, 198, 1)
                      )),
                      const SizedBox(height: 16.00),
                      Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.00),
                            child: Column(
                              children: [
                                Container(
                                  width: 300.00,
                                  margin: EdgeInsets.only(bottom: 6.00),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Name',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  123, 88, 198, 1))
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  123, 88, 198, 1))
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
                                        name = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: 300.00,
                                  margin: EdgeInsets.only(bottom: 6.00),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Email',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  123, 88, 198, 1))
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  123, 88, 198, 1))
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
                                        email = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: 300.00,
                                  margin: const EdgeInsets.only(top: 6.00),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
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
                                        password = value;
                                      });
                                    },
                                  ),
                                ),
                                Container(
                                  width: 300.00,
                                  margin: const EdgeInsets.only(top: 6.00),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: const Text('Student'),
                                        leading: Radio<String>(
                                          value: 'Student',
                                          groupValue: role,
                                          onChanged: (String? value) {
                                            setState(() {
                                              role = value!;
                                            });
                                          },
                                        ),
                                      ),
                                      ListTile(
                                        title: const Text('Educator'),
                                        leading: Radio<String>(
                                          value: 'Educator',
                                          groupValue: role,
                                          onChanged: (String? value) {
                                            setState(() {
                                              role = value!;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                                Container(
                                  width: 300.00,
                                  margin: EdgeInsets.only(bottom: 6.00),
                                  child: TextFormField(
                                    decoration: const InputDecoration(
                                      labelText: 'Avatar',
                                      enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  123, 88, 198, 1))
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromRGBO(
                                                  123, 88, 198, 1))
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
                                        avatar = value;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16.00),
                                ElevatedButton(onPressed: handleSubmit,
                                  style: ButtonStyle(
                                      backgroundColor: MaterialStateColor
                                          .resolveWith((states) =>
                                      const Color.fromRGBO(123, 88, 198, 1))),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Register', style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                                  ),
                                )
                              ],
                            ),
                          ))
                    ]
                ),
              )
          )
      ),
    );
  }
}