import 'dart:convert';

import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../constants.dart';

class JoinSchoolPromptPopup extends StatefulWidget {
  const JoinSchoolPromptPopup({super.key});

  @override
  State<JoinSchoolPromptPopup> createState() => _JoinSchoolPromptPopupState();
}

class _JoinSchoolPromptPopupState extends State<JoinSchoolPromptPopup> {
  String schoolName = '';
  bool error = false;
  String code = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 280,
        padding: const EdgeInsets.all(28.0),
        child: schoolName.isNotEmpty? Center(child:
          Text('Joined $schoolName', style: const TextStyle(color: Color.fromRGBO(123, 88, 198, 1), fontSize: 20.0, fontWeight: FontWeight.w600))
        ) : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter school code', style: TextStyle(color: Color.fromRGBO(123, 88, 198, 1), fontSize: 20.0, fontWeight: FontWeight.w600)),
            const SizedBox(height: 20),
            SizedBox(
              width: 245,
              child: TextField(decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromRGBO(123, 88, 198, 1), width: 2.0)),
                hintText: 'E.g. ABCDEF',
                labelText: 'Invite code',
                errorText: error? 'Invalid code' : null
              ), onChanged: (String value) => setState(() => code = value)),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {
              post(Uri.parse('${apiBaseUrl}join-school'), headers: {'Content-Type': 'application/json', 'Authorization': "Bearer ${prefs.get('token')}"}, body: jsonEncode({
                'code': code,
              })).then((value) {
                if (value.statusCode != 200) {
                  setState(() => error = true);
                } else {
                  setState(() => schoolName = jsonDecode(value.body)['name']);
                  prefs.setString('school', schoolName);
                }
              });
            },
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromRGBO(123, 88, 198, 1))),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Go', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
