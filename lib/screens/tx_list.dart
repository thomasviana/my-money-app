import 'package:flutter/material.dart';
import 'package:my_money/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:my_money/constants.dart';
import 'add_record.dart';

// ignore: must_be_immutable
class TxList extends StatelessWidget {
  final List<Transaction> transactions;

  TxList({required this.transactions});

  /*  = [
/*     Transaction(title: 'title', tag: 'tag', amount: 100, date: DateTime.now()),
    Transaction(title: 'title', tag: 'tag', amount: 100, date: DateTime.now()),
    Transaction(title: 'title', tag: 'tag', amount: 100, date: DateTime.now()),
    Transaction(title: 'title', tag: 'tag', amount: 100, date: DateTime.now()),
    Transaction(title: 'title', tag: 'tag', amount: 100, date: DateTime.now()) */
  ]; */

  final currency = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return ListTile(
            horizontalTitleGap: 20,
            contentPadding: EdgeInsets.symmetric(horizontal: 30),
            title: Text(transactions[index].title, style: kTitleTextStyle),
            subtitle: Text(
              transactions[index].tag,
              style: kTagTextStyle,
            ),
            leading: Icon(Icons.forward),
            trailing: Text('\$ ${currency.format(transactions[index].amount)}',
                style: kAmountTextStyle),
          );
        },
      ),
    );
  }
}
