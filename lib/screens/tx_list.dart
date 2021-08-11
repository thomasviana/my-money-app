import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:my_money/models/transaction.dart';
import 'package:my_money/constants.dart';

final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;

class TxList extends StatelessWidget with ChangeNotifier {
  final currency = NumberFormat("#,##0.00", "en_US");
  // final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: _fireStore
                  .collection('tx')
                  .orderBy('date', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).accentColor,
                      color: Colors.black,
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
                      amount: txAmount,
                      // date: DateFormat.MMMd()
                      //     .add_jm()
                      //     .format((txDate.toDate()))
                      //     .toString(),
                      date: txDate,
                      id: txId,
                      type: txType,
                    );
                    txList.add(newTx);
                  }

                  return Column(
                    children: [
                      Expanded(
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
                                    FirebaseFirestore.instance.runTransaction(
                                        (Transaction myTransaction) async {
                                      myTransaction.delete(
                                          snapshot.data!.docs[index].reference);
                                    });
                                    // widget.deleteTx(txList[index].id);
                                  },
                                ),
                              ],
                              child: Container(
                                child: ListTile(
                                  horizontalTitleGap: 20,
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 25),
                                  title: Text(txList[index].title,
                                      style: kTitleTextStyle),
                                  subtitle: Text(
                                    // DateFormat.yMMMMd().format(txList[index].date),
                                    DateFormat.MMMd()
                                        .add_jm()
                                        .format((txList[index].date.toDate()))
                                        .toString(),
                                    // txList[index].date,
                                    style: kDateTextStyle,
                                  ),
                                  leading: txList[index].type == 'Expense'
                                      ? CircleAvatar(
                                          backgroundColor: Colors.black,
                                          child: Icon(Icons.arrow_back,
                                              color: Theme.of(context)
                                                  .accentColor),
                                        )
                                      : CircleAvatar(
                                          backgroundColor:
                                              Theme.of(context).accentColor,
                                          child: Icon(Icons.arrow_forward,
                                              color: Colors.black),
                                        ),
                                  trailing: Container(
                                    width: 120,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                              '\$ ${currency.format(txList[index].amount)}',
                                              style: kAmountTextStyle),
                                        ),
                                        Text(txList[index].tag,
                                            style: kTagTextStyle),
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
              }),
        ),
      ),
    );
  }
}
