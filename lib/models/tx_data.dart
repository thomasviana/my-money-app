import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;

class TxData extends ChangeNotifier {
  List<Tx> _items = [];

  List<Tx> get items {
    return [..._items];
  }

  Future<void> addTx(Tx newTx) async {
    FirebaseFirestore.instance.collection('tx').add(
      {
        'title': newTx.title,
        'tag': newTx.tag,
        'amount': newTx.amount,
        'date': newTx.date,
        'id': newTx.id,
        'type': newTx.type,
      },
    );
    notifyListeners();
  }

  Future<void> getData() async {
    QuerySnapshot querySnapshot = await _fireStore.collection('tx').get();
    final allData = querySnapshot.docs;

    List<Tx> txList = [];
    for (var tx in allData) {
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
        // date: DateFormat.MMMd().add_jm().format((txDate.toDate())).toString(),
        date: txDate,
        id: txId,
        type: txType,
      );
      txList.add(newTx);
    }
    _items = txList;
    notifyListeners();
  }
}
