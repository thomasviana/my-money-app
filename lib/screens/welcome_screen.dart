import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Icon(
                Icons.monetization_on_rounded,
                size: 200,
              ),
            ),
            SizedBox(
              width: 200,
              child: Divider(),
            ),
            Text(
              'My Money',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
              width: 200,
              child: Divider(),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.amber,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Text('Log In'),
              ),
            ),
            SizedBox(
              height: 0,
              width: 200,
              child: Divider(),
            ),
            Container(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
                child: Text('Register'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
