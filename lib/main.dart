
import 'package:flutter/material.dart';
import 'package:my_money/screens/welcome_screen.dart';
import 'widgets/main_cards.dart';
import 'package:intl/intl.dart';
import 'package:my_money/models/transaction.dart';
import 'screens/home_screen.dart';
import 'package:my_money/screens/tx_list.dart';
import 'screens/app_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Money App',
      theme: ThemeData.dark().copyWith(
        accentColor: Colors.amber,
        cardTheme: CardTheme(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/home': (context) => MainAppScreen(),
        '/records': (context) => TxList(transactions: [],),
      },
    );
  }
}
