import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';
import 'package:my_money/constants.dart';
import 'package:my_money/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:my_money/providers/auth.dart';

class AuthScreen extends StatefulWidget {
  static const id = '/auth-screeen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late bool _registerMode = false;
  late bool _loginMode = false;
  late String name;
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

  void showError(error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(error, textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).errorColor,
      ),
    );
    return;
  }

  Future<void> _trySubmit() async {
    final _isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_isValid && _registerMode) {
      setState(() {
        showSpinner = true;
      });
      try {
        Provider.of<Auth>(context).login(email, password);
        Navigator.pushReplacementNamed(context, HomeScreen.id);
        setState(() {
          showSpinner = false;
        });
      } on PlatformException catch (e) {
        showError(e.message);
      }
    } else if (_isValid && _loginMode) {
      try {
        Provider.of<Auth>(context).signUp(name, email, password);
        Navigator.pushReplacementNamed(context, HomeScreen.id);
        setState(() {
          showSpinner = false;
        });
      } on PlatformException catch (e) {
        showError(e.message);
      }
    }
    passwordController.clear();
    confirmPasswordController.clear();
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
          child: Form(
            key: _formKey,
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
                if (_registerMode)
                  TextFormField(
                    key: ValueKey('name'),
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      name = value.trim();
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Full Name',
                      hoverColor: Colors.green,
                    ),
                  ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  key: ValueKey('email'),
                  controller: emailController,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    email = value.trim();
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your email',
                    hoverColor: Colors.green,
                  ),
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
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
                    password = value.trim();
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter password',
                  ),
                  validator: _registerMode
                      ? (value) {
                          if (value!.isEmpty || value.length < 8) {
                            return 'Password must be at least 8 characters long.';
                          }
                          return null;
                        }
                      : null,
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
                      password = value.trim();
                    },
                    decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Confirm password',
                    ),
                    validator: _registerMode
                        ? (value) {
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              return 'Password doesn\'t match';
                            }
                            if (value!.isEmpty || value.length < 8) {
                              return 'Password must be at least 8 characters long.';
                            }
                            return null;
                          }
                        : null,
                  ),
                SizedBox(
                  height: 24.0,
                ),
                RoundedButton(
                  buttonColor: _loginMode
                      ? Theme.of(context).accentColor
                      : Colors.grey.shade800,
                  title: _loginMode ? 'Log In' : 'Register',
                  textStyle: TextStyle(
                      color: _loginMode ? Colors.black : Colors.white),
                  onPressed: _trySubmit,
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
      ),
    );
  }
}
