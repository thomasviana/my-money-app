import 'package:flutter/material.dart';
import 'package:my_money/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:my_money/constants.dart';
import 'add_record.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class TxList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TxList({required this.transactions, required this.deleteTx});

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
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  print('Delete');
                  // ignore: unnecessary_statements
                  deleteTx;
                },
              ),
            ],
            child: Container(
              child: ListTile(
                onLongPress: () {
                  // ignore: unnecessary_statements
                  deleteTx;
                  print('deleting');
                },
                horizontalTitleGap: 20,
                contentPadding: EdgeInsets.symmetric(horizontal: 30),
                title: Text(transactions[index].title, style: kTitleTextStyle),
                subtitle: Text(
                  transactions[index].tag,
                  style: kTagTextStyle,
                ),
                leading: Icon(Icons.forward),
                trailing: Text(
                    '\$ ${currency.format(transactions[index].amount)}',
                    style: kAmountTextStyle),
              ),
            ),
          );
        },
      ),
    );
  }
}
