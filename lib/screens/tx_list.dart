import 'package:flutter/material.dart';
import 'package:my_money/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:my_money/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TxList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  // final Icon icon;

  TxList({required this.transactions, required this.deleteTx});

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
                  deleteTx(transactions[index].id);
                },
              ),
            ],
            child: Container(
              child: ListTile(
                horizontalTitleGap: 20,
                contentPadding: EdgeInsets.symmetric(horizontal: 25),
                title: Text(transactions[index].title, style: kTitleTextStyle),
                subtitle: Text(
                  DateFormat.yMMMMd().format(transactions[index].date),
                  style: kDateTextStyle,
                ),
                leading: transactions[index].type == 'Expense'
                    ? Icon(Icons.forward, color: Colors.red)
                    : Icon(Icons.forward, color: Colors.green),
                trailing: Container(
                  width: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                            '\$ ${currency.format(transactions[index].amount)}',
                            style: kAmountTextStyle),
                      ),
                      Text(transactions[index].tag, style: kTagTextStyle),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
