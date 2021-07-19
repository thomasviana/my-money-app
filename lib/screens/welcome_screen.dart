import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'package:my_money/widgets/rounded_button.dart';

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
            ),
            Text(
              'My Money',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 40,
              width: 200,
            ),
            RoundedButton(
              buttonColor: Theme.of(context).accentColor,
              title: 'Log In',
              textStyle: TextStyle(color: Colors.black),
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            SizedBox(
              height: 0,
              width: 200,
            ),
            RoundedButton(
              buttonColor: Colors.grey.shade800,
              title: 'Register',
              textStyle: TextStyle(color: Colors.white),
              onPressed: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
