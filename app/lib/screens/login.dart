import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(123, 88, 198, 1),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20.00),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Image(image: AssetImage('assets/images/logo.png'), width: 200),
                  const SizedBox(height: 16.00),
                  Form(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.00),
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                              labelText: 'User ID',
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.4))
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white.withOpacity(0.4))
                              ),
                              labelStyle: TextStyle(
                                color: Colors.white.withOpacity(0.4),
                              ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          obscureText: true,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white.withOpacity(0.4))
                            ),
                            labelStyle: TextStyle(
                              color: Colors.white.withOpacity(0.4),
                            ),
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return 'Field must not be empty';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.00),
                        ElevatedButton(onPressed: () => {},
                          style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white)),
                          child: const Text('Log in', style: TextStyle(color: Color.fromRGBO(123, 88, 198, 1), fontWeight: FontWeight.w700)),
                        )
                      ],
                    ),
                  ))
                ]
              )
          )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}