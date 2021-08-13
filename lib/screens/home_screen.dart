import 'package:flutter/material.dart';
import 'package:my_money/providers/auth.dart';
import 'package:my_money/widgets/home/home_listview.dart';
import 'package:my_money/widgets/home/home_card.dart';
import 'package:provider/provider.dart';
import 'package:my_money/providers/transactions.dart';

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final userId = Provider.of<Auth>(context).userId;
      Provider.of<Txs>(
        context,
      ).getData(userId).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
