import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                onTap: () {},
                leading: CircleAvatar(
                  backgroundColor: Color.fromRGBO(224, 70, 70, 1),
                  child: Text('WH', style: TextStyle(color: Colors.white)),
                  radius: 20.00,
                ),
                title: Text('William Herring', style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold
                )),
                trailing: IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 16.0),
              ListTile(
                onTap: () => Navigator.pop(context),
                leading: Icon(Icons.home_filled, color: Colors.black54),
                title: Text('Home', style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0
                )),
              ),
              ListTile(
                onTap: () => Navigator.pushReplacementNamed(context, '/schedule'),
                leading: Icon(Icons.calendar_month, color: Colors.black54),
                title: Text('Schedule', style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0
                )),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.list, color: Colors.black54),
                title: Text('Classes', style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0
                )),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.newspaper, color: Colors.black54),
                title: Text('News', style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0
                )),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.event, color: Colors.black54),
                title: Text('Events', style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20.0
                )),
              ),
            ],
          ),
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
              InkWell(
                onTap: () {},
                child: Ink(
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
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.7),
                          blurRadius: 4,
                          spreadRadius: 2,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        ),
                        Text('S10', style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                        ))
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