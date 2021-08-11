import 'package:flutter/material.dart';
import 'budget_cards.dart';
import 'package:provider/provider.dart';
import 'package:my_money/providers/transactions.dart';
import 'package:my_money/models/transaction.dart';

class BudgetsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final txsData = Provider.of<Txs>(context);
    final transactions = txsData.items;

    double totalSum = 0;
    double totalFCR = 0;
    double totalSEG = 0;
    double totalDIV = 0;
    double totalDAR = 0;
    double totalSOS = 0;
    double totalSUE = 0;

    double? getBudget(Tx tx, String budget) {
      totalSum = 0;
      if (tx.tag == budget) {
        var newValue = tx.amount;
        totalSum += newValue;
      }
      return totalSum;
    }

    for (var tx in transactions) {
      if (tx.type == 'Expense') {
        var valueFCR = getBudget(tx, 'FCR');
        totalFCR += valueFCR!;
        var valueSEG = getBudget(tx, 'SEG');
        totalSEG += valueSEG!;
        var valueDIV = getBudget(tx, 'DIV');
        totalDIV += valueDIV!;
        var valueDAR = getBudget(tx, 'DAR');
        totalDAR += valueDAR!;
        var valueSOS = getBudget(tx, 'SOS');
        totalSOS += valueSOS!;
        var valueSUE = getBudget(tx, 'SUE');
        totalSUE += valueSUE!;
      }
    }

    return GridView(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
      ),
      children: [
        BudgetCards(
          title: 'FCR',
          value: totalFCR,
        ),
        BudgetCards(
          title: 'SEG',
          value: totalSEG,
        ),
        BudgetCards(
          title: 'DIV',
          value: totalDIV,
        ),
        BudgetCards(
          title: 'DAR',
          value: totalDAR,
        ),
        BudgetCards(
          title: 'SOS',
          value: totalSOS,
        ),
        BudgetCards(
          title: 'SUE',
          value: totalSUE,
        ),
      ],
    );
  }
}
