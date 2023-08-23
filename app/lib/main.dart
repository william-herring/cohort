import 'package:app/screens/classes.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/profile.dart';
import 'package:app/screens/register.dart';
import 'package:app/screens/schedule.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/screens/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user.dart';

late final SharedPreferences prefs;
// late User currentUser;
User currentUser = User(
  'HERR80',
  'Student',
  'William Herring',
  'email@e.com',
  'https://avatars.worldcubeassociation.org/uploads/user/avatar/2019HERR14/1673589855.jpeg'
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cohort',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(123, 88, 198, 1),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color.fromRGBO(123, 88, 198, 1),
          shadowColor: Colors.transparent,
        )
      ),
      home: const LoginScreen(),
      routes: {
        '/home': (context) => HomeScreen(currentUser),
        '/schedule': (context) => ScheduleScreen(currentUser),
        '/profile': (context) => ProfileScreen(currentUser),
        '/register': (context) => const RegisterScreen(),
        '/classes': (context) => ClassesScreen(currentUser)
      },
    );
  }
}
