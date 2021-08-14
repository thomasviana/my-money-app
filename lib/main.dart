import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_money/providers/auth.dart';
import 'package:provider/provider.dart';

import 'package:my_money/screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import 'screens/app_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/welcome_screen.dart';
import 'providers/transactions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //     DeviceOrientation.portraitDown,
  //   ],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: Txs(),
        ),
      ],
      child: MaterialApp(
        title: 'My Money App',
        theme: ThemeData(
          backgroundColor: Color.fromRGBO(225, 239, 59, 1),
          accentColor: Color.fromRGBO(225, 239, 59, 1),
          fontFamily: 'Ubuntu',
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.black),
            titleSpacing: 10,
            backgroundColor: Color.fromRGBO(225, 239, 59, 1),
          ),
          cardTheme: CardTheme(
            color: Colors.grey[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          HomeScreen.id: (context) => MainAppScreen(),
          AuthScreen.id: (context) => AuthScreen(),
        },
      ),
    );
  }
}
