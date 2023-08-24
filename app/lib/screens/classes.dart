import 'dart:convert';
import 'dart:js_interop';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import '../main.dart';
import '../models/user.dart';
import '../widgets/modals/join_school.dart';

class ClassesScreen extends StatefulWidget {
  User user;
  ClassesScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<ClassesScreen> createState() => _ClassesScreenState(user);
}

class _ClassesScreenState extends State<ClassesScreen> {
  User user;
  _ClassesScreenState(this.user);

  Future<Widget> buildClassWidgets() async {
    if (prefs.getString('school').isUndefinedOrNull) {
      return const Text('No school data yet. Try joining a school.');
    }

    Response response = await post(Uri.parse('${apiBaseUrl}token'), headers: {'Content-Type': 'application/json', 'Authorization': "Bearer ${prefs.get('token')}"});
    if (response.statusCode != 200) {
      return const Text('Failed to load class list.');
    }

    List<Widget> classes = [];
    for (var classObj in jsonDecode(response.body)['classes']) {
      classes.add(ListTile(
        shape: const Border(
          left: BorderSide(color: Colors.green, width: 2),
        ),
        title: Text(classObj['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(classObj['class_code']),
      ));
    }

    return ListView(children: classes);
  }

  @override
  Widget build(BuildContext context) {
    currentUser = user;
    return Scaffold(
        floatingActionButton: user.role == 'Educator' && prefs.getString('school').isDefinedAndNotNull? FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)) : null,
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
                        onTap: () => Navigator.pop(context),
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
            child: FutureBuilder(future: buildClassWidgets(),
                builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!;
                  }
                  return Container();
                })
          ),
        )
    );
  }
}
