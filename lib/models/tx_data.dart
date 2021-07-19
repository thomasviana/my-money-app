import 'package:flutter/material.dart';
import 'package:my_money/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:my_money/models/transaction.dart';
import 'package:intl/intl.dart';
import 'package:my_money/constants.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;

class TxData extends ChangeNotifier {
  getTxData() {
    _fireStore.collection('tx').get();
  }

  // Future<List<Tx>?> getUserTaskList() async {
  //   QuerySnapshot qShot =
  //       await FirebaseFirestore.instance.collection('userTasks').get();

  //   return qShot.docs
  //       .map((doc) => Tx(
  //             title: doc.data['title'],
  //             tag: doc.data['tag'],
  //             amount: double.parse(doc.data['amount']),
  //             date: doc.data['date'],
  //             id: doc.data['id'],
  //             type: doc.data['type'],
  //           ))
  //       .toList();
  // }
}
