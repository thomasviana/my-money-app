import 'package:flutter/material.dart';
import 'package:my_money/widgets/budget_cards.dart';
import 'package:my_money/providers/transactions.dart';
import 'package:provider/provider.dart';

class BudgetsScreen extends StatelessWidget {
  static const id = 'home_screen';

  double totalIncomes = 0;
  double totalExpenses = 0;

  BudgetsScreen({required this.totalExpenses, required this.totalIncomes});

  @override
  Widget build(BuildContext context) {
    double myBalance = totalIncomes - totalExpenses;

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
                  'My Budgets',
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
              child: GridView(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 2,
                ),
                children: [
                  BudgetCards(
                    title: 'FCR',
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: Colors.black,
                    // value: Provider.of<TxData>(context).totalFCR,
                    value: 0,
                  ),
                  BudgetCards(
                    title: 'SEG',
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: Colors.black,
                    // value: Provider.of<TxData>(context).totalSEG,
                    value: 0,
                  ),
                  BudgetCards(
                    title: 'DIV',
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: Colors.black,
                    // value: Provider.of<TxData>(context).totalDIV,
                    value: 0,
                  ),
                  BudgetCards(
                    title: 'DAR',
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: Colors.black,
                    // value: Provider.of<TxData>(context).totalDAR,
                    value: 0,
                  ),
                  BudgetCards(
                    title: 'SOS',
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: Colors.black,
                    // value: Provider.of<TxData>(context).totalSOS,
                    value: 0,
                  ),
                  BudgetCards(
                    title: 'SUE',
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: Colors.black,
                    // value: Provider.of<TxData>(context).totalSUE,
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
