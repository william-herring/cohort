import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: ListView(
          children: [
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Home', style: TextStyle(
          fontWeight: FontWeight.bold
        )),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 15.0),
            child: CircleAvatar(
              backgroundColor: Color.fromRGBO(224, 70, 70, 1),
              child: Text('WH', style: TextStyle(color: Colors.white)),
              radius: 20.00,
            ),
          )
        ],
      ),
      body: Container(

      ),
    );
  }
}
