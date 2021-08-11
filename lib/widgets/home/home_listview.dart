import 'package:flutter/material.dart';
import 'package:my_money/widgets/home/home_card.dart';
import 'package:provider/provider.dart';
import 'package:my_money/providers/transactions.dart';

class HomeListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final txsData = Provider.of<Txs>(context);
    final transactions = txsData.items;
    double totalExpenses = 0;
    double totalIncomes = 0;

    for (var tx in transactions) {
      if (tx.type == 'Expense') {
        var newValue = tx.amount;
        totalExpenses += newValue;
      }
      if (tx.type == 'Income') {
        var newValue = tx.amount;
        totalIncomes += newValue;
      }
    }
    return ListView(
      children: [
        HomeCard(
          title: 'My Balance',
          icon: Icons.account_balance_wallet_rounded,
          iconColor: Colors.black,
          // value: myBalance,
          value: totalIncomes - totalExpenses,
        ),
        SizedBox(
          height: 20,
        ),
        HomeCard(
          title: 'Incomes',
          icon: Icons.arrow_circle_down_rounded,
          iconColor: Colors.black,
          value: totalIncomes,
        ),
        SizedBox(
          height: 20,
        ),
        HomeCard(
          title: 'Expenses',
          icon: Icons.arrow_circle_up_rounded,
          iconColor: Colors.black,
          // value: Provider.of<TxData>(context).expenses,
          value: totalExpenses,
        ),
      ],
    );
  }
}
