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
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22.0, 12.0, 22.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: Container(
                    padding: EdgeInsets.all(26.0),
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(14.0)),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(101, 65, 178, 1.0),
                          Color.fromRGBO(123, 88, 198, 0.9)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight
                      )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('Applied Computing', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                            )),
                            SizedBox(width: 8.0),
                            Text('COMP11A', style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            )),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.0)
                              ),
                              child: Center(
                                child: Text('NOW', style: TextStyle(
                                    color: const Color.fromRGBO(123, 88, 198, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0
                                )),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
