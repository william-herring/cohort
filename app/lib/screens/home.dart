import 'dart:js_interop';

import 'package:app/widgets/modals/join_school.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:app/main.dart';

class HomeScreen extends StatefulWidget {
  User user;
  HomeScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState(user);
}

class _HomeScreenState extends State<HomeScreen> {
  User user;
  _HomeScreenState(this.user);

  @override
  Widget build(BuildContext context) {
    currentUser = user;
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    onTap: () => Navigator.pushReplacementNamed(context, '/profile'),
                    leading: user.avatar != null? CircleAvatar(
                      radius: 20.00,
                      backgroundImage: NetworkImage(user.avatar.toString()),
                    ) :
                    const CircleAvatar(
                      backgroundColor: Color.fromRGBO(224, 70, 70, 1),
                      radius: 20.00,
                      child: Text('WH', style: TextStyle(color: Colors.white)),
                    ),
                    title: Text(user.name.toString(), style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                    )),
                    trailing: IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    onTap: () => Navigator.pop(context),
                    leading: const Icon(Icons.home_filled, color: Colors.black54),
                    title: const Text('Home', style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0
                    )),
                  ),
                  ListTile(
                    onTap: () => Navigator.pushReplacementNamed(context, '/schedule'),
                    leading: const Icon(Icons.calendar_month, color: Colors.black54),
                    title: const Text('Schedule', style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0
                    )),
                  ),
                  ListTile(
                    onTap: () => Navigator.pushReplacementNamed(context, '/classes'),
                    leading: const Icon(Icons.list, color: Colors.black54),
                    title: const Text('Classes', style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0
                    )),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.newspaper, color: Colors.black54),
                    title: const Text('News', style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0
                    )),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.event, color: Colors.black54),
                    title: const Text('Events', style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0
                    )),
                  ),
                ],
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: ListTile(
                    onTap: () => showDialog(context: context, builder: (BuildContext context) => const JoinSchoolPromptPopup()),
                    title: const Text('Join a School', style: TextStyle(
                        color: Colors.black54,
                        fontSize: 20.0
                    )),
                  ),
                ),
              )
            ],
          )
        ),
      ),
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(
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
      ),
      body: SizedBox.expand(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22.0, 12.0, 22.0, 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: prefs.get('school').isNull? [const Text('No school data yet. Try joining a school.')] : [
              InkWell(
                onTap: () {},
                child: Ink(
                    padding: const EdgeInsets.all(26.0),
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(14.0)),
                      gradient: const LinearGradient(
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
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text('Applied Computing', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                            )),
                            const SizedBox(width: 8.0),
                            Text('COMP11A', style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0
                            )),
                            const Spacer(),
                            MediaQuery.of(context).size.width > 400? Container(
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6.0)
                              ),
                              child: const Center(
                                child: Text('NOW', style: TextStyle(
                                    color: Color.fromRGBO(123, 88, 198, 1),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0
                                )),
                              ),
                            ) : Container()
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
              ),
              const SizedBox(height: 30),
              Align(alignment: Alignment.centerLeft, child: Text("The latest from ${prefs.get('school').toString()}:", style: const TextStyle(
                color: Color.fromRGBO(123, 88, 198, 1),
                fontWeight: FontWeight.bold,
                fontSize: 21.0
              )))
            ],
          ),
        ),
      )
    );
  }
}