import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_money/providers/auth.dart';
import 'package:my_money/widgets/home/home_listview.dart';
import 'package:provider/provider.dart';
import 'package:my_money/providers/transactions.dart';
import 'package:my_money/constants.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;
  String? _userName = '';
  String? _userId;
  late User user;

  @override
  void initState() {
    super.initState();
    onRefresh(FirebaseAuth.instance.currentUser);
  }

  onRefresh(userCred) {
    setState(() {
      user = userCred;
    });
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      var userData = Provider.of<Auth>(context);
      Provider.of<Txs>(
        context,
      ).getData(kThisMonth).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      _userId = userData.userId;
      _userName = userData.userName;
      print(_userId);
      print(user.uid);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Hi, $_userName',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.start,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20, top: 30),
                  child: Hero(
                    tag: 'logo',
                    child: Icon(
                      Icons.monetization_on_rounded,
                      size: 120,
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                ),
                Text(
                  'My Money Test',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 0,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  )),
              child: _isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : HomeListView(),
            ),
          )
        ],
      ),
    );
  }
}
