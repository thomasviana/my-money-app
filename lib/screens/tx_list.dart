import 'package:flutter/material.dart';
import 'package:my_money/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:my_money/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;

class TxList extends StatefulWidget {
  final Function deleteTx;

  TxList({required this.deleteTx});

  @override
  _TxListState createState() => _TxListState();
}

class _TxListState extends State<TxList> {
  final currency = NumberFormat("#,##0.00", "en_US");
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      loggedInUser = user;
      print(user!.email);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
          stream: _fireStore
              .collection('tx')
              // .orderBy('time', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.amber,
                ),
              );
            } else {
              final txs = snapshot.data!.docs;
              List<Tx> txList = [];
              for (var tx in txs) {
                final txTitle = tx['title'];
                final txTag = tx['tag'];
                final txAmount = tx['amount'];
                final txDate = tx['date'];
                final txId = tx['id'];
                final txType = tx['type'];

                final newTx = Tx(
                  title: txTitle,
                  tag: txTag,
                  amount: double.parse(txAmount),
                  date: txDate,
                  id: txId,
                  type: txType,
                );
                txList.add(newTx);
                print(newTx.amount);
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: txList.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            widget.deleteTx(txList[index].id);
                          },
                        ),
                      ],
                      child: Container(
                        child: ListTile(
                          horizontalTitleGap: 20,
                          contentPadding: EdgeInsets.symmetric(horizontal: 25),
                          title:
                              Text(txList[index].title, style: kTitleTextStyle),
                          subtitle: Text(
                            // DateFormat.yMMMMd().format(txList[index].date),
                            txList[index].date,
                            style: kDateTextStyle,
                          ),
                          leading: txList[index].type == 'Expense'
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
                                      '\$ ${currency.format(txList[index].amount)}',
                                      style: kAmountTextStyle),
                                ),
                                Text(txList[index].tag, style: kTagTextStyle),
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
          }),
    );
  }
}
