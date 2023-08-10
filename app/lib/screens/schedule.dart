import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime date = DateTime.now();

  _selectDate() async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: date, firstDate: DateTime(2023), lastDate: DateTime(2024));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
      });
    }
  }

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
                  onTap: () => Navigator.pushReplacementNamed(context, '/home'),
                  leading: Icon(Icons.home_filled, color: Colors.black54),
                  title: Text('Home', style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20.0
                  )),
                ),
                ListTile(
                  onTap: () => Navigator.pop(context),
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
          title: Text('Schedule', style: TextStyle(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(date.toString(), style: TextStyle(
                      color: Colors.black54,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold
                    )),
                    IconButton(icon: Icon(Icons.calendar_month), onPressed: _selectDate, color: Colors.black54)
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}
