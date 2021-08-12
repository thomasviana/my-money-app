import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:my_money/constants.dart';
import 'package:my_money/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:my_money/constants.dart';

class AuthScreen extends StatefulWidget {
  static const id = '/auth-screeen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  late bool _registerMode = false;
  late bool _loginMode = false;

  late String email;
  late String password;
  bool showSpinner = false;

  @override
  void didChangeDependencies() {
    String _mode = ModalRoute.of(context)!.settings.arguments as String;
    if (_mode == 'LoginMode') {
      setState(() {
        _loginMode = true;
      });
    } else {
      setState(() {
        _registerMode = true;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        progressIndicator: CircularProgressIndicator(
          backgroundColor: Theme.of(context).accentColor,
          color: Colors.black,
        ),
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Icon(
                      Icons.monetization_on_rounded,
                      size: 200,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              Text(
                'My Money',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50.0,
              ),
              TextFormField(
                key: ValueKey('email'),
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter you email',
                  hoverColor: Colors.green,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                key: ValueKey('pasword'),
                controller: passwordController,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              if (_registerMode)
                SizedBox(
                  height: 8.0,
                ),
              if (_registerMode)
                TextFormField(
                  key: ValueKey('confirmPasword'),
                  controller: confirmPasswordController,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Confirm password',
                  ),
                ),
              SizedBox(
                height: 24.0,
              ),
              if (_loginMode)
                RoundedButton(
                  buttonColor: Theme.of(context).accentColor,
                  title: 'Log In',
                  textStyle: TextStyle(color: Colors.black),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final existingUser =
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              if (_registerMode)
                RoundedButton(
                  buttonColor: Colors.grey.shade800,
                  title: 'Register',
                  textStyle: TextStyle(color: Colors.white),
                  onPressed: () async {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Password doesn\'t match',
                              textAlign: TextAlign.center),
                          backgroundColor: Theme.of(context).errorColor,
                        ),
                      );
                      return;
                    }
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _registerMode = !_registerMode;
                    _loginMode = !_loginMode;
                  });
                },
                child: Text(_loginMode
                    ? 'Create new account'
                    : 'I alreade have an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
