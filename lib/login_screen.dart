import 'package:flutter/material.dart';
import 'information_page.dart';
import 'main.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: (value) {
            email = value;
          },
          decoration: InputDecoration(labelText: 'Email'),
        ),
        TextField(
          onChanged: (value) {
            password = value;
          },
          obscureText: true,
          decoration: InputDecoration(labelText: 'Password'),
        ),
        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Validate and log in the user
            // Pass the user information to the next screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformationPage(
                    loggedInUser: User(
                  name: 'YourName', // Replace with actual name
                  surname: 'YourSurname', // Replace with actual surname
                  dateOfBirth:
                      DateTime.now(), // Replace with actual date of birth
                  email: email,
                  password: 'YourPassword', // Replace with actual password
                )),
              ),
            );
          },
          child: Text('Log In'),
        ),
      ],
    );
  }
}
