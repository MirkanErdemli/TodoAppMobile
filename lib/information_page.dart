import 'package:flutter/material.dart';
import 'main.dart';

class InformationPage extends StatelessWidget {
  final User loggedInUser;

  InformationPage({required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile Information',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text('Name: ${loggedInUser.name}'),
            Text('Surname: ${loggedInUser.surname}'),
            Text('Date of Birth: ${loggedInUser.dateOfBirth}'),
            Text('Mail: ${loggedInUser.email}'),
          ],
        ),
      ),
    );
  }
}
