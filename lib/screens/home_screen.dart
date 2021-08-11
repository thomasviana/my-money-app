import 'package:flutter/material.dart';
import 'package:my_money/widgets/home_card.dart';
import 'package:provider/provider.dart';
import 'package:my_money/providers/transactions.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  @override
  Widget build(BuildContext context) {
    // double myBalance = Provider.of<TxData>(context).incomes -
    //     Provider.of<TxData>(context).expenses;

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
              child: ListView(
                children: [
                  HomeCard(
                    title: 'My Balance',
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: Colors.black,
                    // value: myBalance,
                    value: 0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HomeCard(
                    title: 'Incomes',
                    icon: Icons.arrow_circle_down_rounded,
                    iconColor: Colors.black,
                    // value: Provider.of<TxData>(context).incomes,
                    value: 0,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  HomeCard(
                    title: 'Expenses',
                    icon: Icons.arrow_circle_up_rounded,
                    iconColor: Colors.black,
                    // value: Provider.of<TxData>(context).expenses,
                    value: 0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
