import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
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
              width: 200,
              child: Divider(),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
