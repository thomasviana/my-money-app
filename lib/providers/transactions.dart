import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;

class Txs extends ChangeNotifier {
  List<Tx> _items = [];

  List<Tx> get items {
    return [..._items];
  }

  Tx findById(String id) {
    return _items.firstWhere((tx) => tx.id == id);
  }

  Future<void> getData(String userId) async {
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

  Future<void> deletTx(String id) async {
    final txIndex = _items.indexWhere((tx) => tx.id == id);
    await FirebaseFirestore.instance.collection('tx').doc('txIndex').delete();
    _items.removeAt(txIndex);
    notifyListeners();
    _items.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }
}
