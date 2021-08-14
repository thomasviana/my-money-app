import 'package:flutter/material.dart';
import 'package:my_money/providers/auth.dart';
import 'package:my_money/providers/transactions.dart';
import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_money/constants.dart';

class TxsList extends StatelessWidget {
  void deletTx(BuildContext context, String id) {
    final userId = Provider.of<Auth>(context, listen: false).userId;
    Provider.of<Txs>(context, listen: false).deletTx(userId, id);
  }

  @override
  Widget build(BuildContext context) {
    final txsData = Provider.of<Txs>(context);
    final transactions = txsData.items;
    return Column(
      children: [
        Expanded(
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
                      deletTx(context, transactions[index].id);
                    },
                  ),
                ],
                child: Container(
                  child: ListTile(
                    horizontalTitleGap: 20,
                    contentPadding: EdgeInsets.symmetric(horizontal: 25),
                    title:
                        Text(transactions[index].title, style: kTitleTextStyle),
                    subtitle: Text(
                      DateFormat.MMMd()
                          .add_jm()
                          .format((transactions[index].date.toDate()))
                          .toString(),
                      style: kDateTextStyle,
                    ),
                    leading: transactions[index].type == 'Expense'
                        ? CircleAvatar(
                            backgroundColor: Colors.black,
                            child: Icon(Icons.arrow_back,
                                color: Theme.of(context).accentColor),
                          )
                        : CircleAvatar(
                            backgroundColor: Theme.of(context).accentColor,
                            child:
                                Icon(Icons.arrow_forward, color: Colors.black),
                          ),
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
        ),
      ],
    );
  }
}
