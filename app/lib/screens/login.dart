import 'dart:convert';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:app/constants.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String userID = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();

  handleSubmit() async {
    _formKey.currentState?.validate();
    Response response = await post(Uri.parse('${apiBaseUrl}token'), headers: {'Content-Type': 'application/json'}, body: jsonEncode({
      'user_id': userID,
      'password': password,
    }));

    await prefs.setString('token', jsonDecode(response.body)['token']);

    Response userData = await get(Uri.parse('${apiBaseUrl}get-user'), headers: {'Authorization': "Bearer ${jsonDecode(response.body)['token']}"});
    user = User.fromJson(jsonDecode(userData.body));

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
        title: const Text('Log in', style: TextStyle(
          fontWeight: FontWeight.bold
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(onPressed: handleSubmit,
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)),
              child: const Text("Sign up", style: TextStyle(color: Color.fromRGBO(123, 88, 198, 1), fontWeight: FontWeight.w700)),
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
                height: 430,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Proceed to Cohort', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.00,
                      color: Color.fromRGBO(123, 88, 198, 1)
                    )),
                    const SizedBox(height: 16.00),
                    Form(
                      key: _formKey,
                      child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.00),
                      child: Column(
                        children: [
                          Container(
                            width: 300.00,
                            margin: EdgeInsets.only(bottom: 6.00),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'User ID',
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
                                  userID = value;
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
                          const SizedBox(height: 16.00),
                          ElevatedButton(onPressed: handleSubmit,
                            style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromRGBO(123, 88, 198, 1))),
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('Log in', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                            ),
                          )
                        ],
                      ),
                    ))
                  ]
                ),
              )
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}