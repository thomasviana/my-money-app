import 'package:flutter/material.dart';
import 'package:my_money/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:my_money/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;

class TxList extends StatelessWidget with ChangeNotifier {
  final currency = NumberFormat("#,##0.00", "en_US");
  // final _auth = FirebaseAuth.instance;

  // @override
  // void initState() {
  //   super.initState();
  //   getCurrentUser();
  //   updateUI();
  //   print('updated');
  // }

  // void getCurrentUser() async {
  //   try {
  //     final user = _auth.currentUser;
  //     loggedInUser = user;
  //     print(user!.email);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // List<Tx> txList = [];
  // double totalIncomes = 0;
  // double totalExpenses = 0;

  // void updateUI() {
  //   totalIncomes = 0;
  //   totalExpenses = 0;
  //   for (var i = 0; i < txList.length; i++) {
  //     if (txList[i].type == 'Expense') {
  //       // selectedIcon = Icon(Icons.forward, color: Colors.red);
  //       var newValue = txList[i].amount;
  //       totalExpenses += newValue;
  //     }
  //     if (txList[i].type == 'Income') {
  //       // selectedIcon = Icon(Icons.forward, color: Colors.green);
  //       var newValue = txList[i].amount;
  //       totalIncomes += newValue;
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: StreamBuilder<QuerySnapshot>(
            stream: _fireStore
                .collection('tx')
                .orderBy('title', descending: true)
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
                  // var newValue = double.parse(txAmount);
                  // totalExpenses += newValue;
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
    );
  }
}
