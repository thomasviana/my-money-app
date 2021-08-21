import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;

class Txs extends ChangeNotifier {
  final String userId;

  Txs(this.userId);

  List<Tx> _items = [];

  List<Tx> get items {
    return [..._items];
  }

  Tx findById(String id) {
    return _items.firstWhere((tx) => tx.id == id);
  }

  Future<void> getData(int monthIndex) async {
    print('My userID is $userId');
    QuerySnapshot querySnapshot = await _fireStore
        .collection('users/$userId/transactions')
        .orderBy('date')
        .get();
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
        date: txDate,
        id: txId,
        type: txType,
      );

      if (newTx.date.toDate().month - 1 == monthIndex) {
        txList.add(newTx);
      }
      print(newTx.date.toDate().month - 1);
      print(monthIndex);
    }
    _items = txList;
    notifyListeners();
  }

  Future<void> addTx(String userId, Tx newTx) async {
    FirebaseFirestore.instance.collection('users/$userId/transactions').add(
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

  Future<void> deletTx(String userId, String id) async {
    final txIndex = _items.indexWhere((tx) => tx.id == id);
    await FirebaseFirestore.instance
        .collection('users/$userId/transactions')
        .doc('txIndex')
        .delete();
    _items.removeAt(txIndex);
    notifyListeners();
    _items.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
