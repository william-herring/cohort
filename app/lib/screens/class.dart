import 'package:flutter/material.dart';
import '../main.dart';
import '../models/user.dart';
import '../widgets/modals/join_school.dart';

class ClassScreen extends StatefulWidget {
  User user;
  String title;
  ClassScreen(this.user, {Key? key, required this.title}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState(user, title);
}

class _ClassScreenState extends State<ClassScreen> {
  User user;
  String classCode;
  _ClassScreenState(this.user, this.classCode);

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
                        onTap: () => Navigator.pushReplacementNamed(context, '/home'),
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
          title: Text(classCode, style: const TextStyle(
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
        body: Placeholder()
    );
  }
}
