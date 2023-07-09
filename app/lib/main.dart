import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cohort',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              const Padding(padding: EdgeInsets.symmetric(vertical: 12.00)),
              const Text("Are you a student, parent or staff member?", style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.00
              ), textAlign: TextAlign.center),
              Padding(padding: const EdgeInsets.only(top: 24.00), child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () => {}, style: ElevatedButton.styleFrom(shape: const StadiumBorder(), primary: Colors.white),
                        child: const Text('Student', style: TextStyle(
                            color: Colors.black,
                        ))
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(onPressed: () => {}, style: ElevatedButton.styleFrom(shape: const StadiumBorder(), primary: Colors.white),
                        child: const Text('Parent/Carer', style: TextStyle(
                          color: Colors.black,
                        ))
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(onPressed: () => {}, style: ElevatedButton.styleFrom(shape: const StadiumBorder(), primary: Colors.white),
                        child: const Text('Staff', style: TextStyle(
                          color: Colors.black,
                        ))
                    )
                  ]
              ))
            ],
          )
        )
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
