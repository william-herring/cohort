import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:app/main.dart';

class ProfileScreen extends StatefulWidget {
  User user;
  ProfileScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState(user);
}

class _ProfileScreenState extends State<ProfileScreen> {
  User user;
  _ProfileScreenState(this.user);

  @override
  Widget build(BuildContext context) {
    currentUser = user;
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 26.0, horizontal: 8.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  onTap: () => Navigator.pop(context),
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
                  onTap: () {},
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
          ),
        ),
        appBar: AppBar(
          title: Text(user.userId, style: const TextStyle(
              fontWeight: FontWeight.bold
          )),
          actions: [
            Container(
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
            )
          ],
        ),
        body: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22.0, 12.0, 22.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(user.name) // Replace with screen elements
              ],
            ),
          ),
        )
    );
  }
}