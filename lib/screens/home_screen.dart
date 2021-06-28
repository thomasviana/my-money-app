import 'package:flutter/material.dart';
import 'package:my_money/widgets/main_cards.dart';
import 'package:my_money/constants.dart';

class HomeScreen extends StatelessWidget {
  double totalIncomes = 100;
  double totalExpenses = 50;

  @override
  Widget build(BuildContext context) {
    double myBalance = totalIncomes - totalExpenses;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
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
              height: 50,
              child: Divider(),
            ),
            Container(
              height: 180,
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.black,
                        size: 60,
                      ),
                      SizedBox(width: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Balance',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '\$ ${currency.format(myBalance)}',
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainCards(
                  icon: (Icons.arrow_circle_down_rounded),
                  iconColor: Colors.green,
                  title: 'Incomes',
                  value: totalIncomes,
                ),
                SizedBox(width: 20),
                MainCards(
                  icon: Icons.arrow_circle_up_rounded,
                  iconColor: Colors.red,
                  title: 'Expenses',
                  value: totalExpenses,
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
