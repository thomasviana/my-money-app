import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/models/transaction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;

class TxData extends ChangeNotifier {
  double totalExpenses = 0;
  double totalIncomes = 0;
  double sumFCR = 0;
  double sumSEG = 0;
  double sumDIV = 0;
  double sumDAR = 0;
  double sumSOS = 0;
  double sumSUE = 0;

  List<Tx> txList = [];

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
        amount: double.parse(txAmount),
        date: DateFormat.MMMd().add_jm().format((txDate.toDate())).toString(),
        id: txId,
        type: txType,
      );
      txList.add(newTx);
      totalIncomes = 0;
      totalExpenses = 0;
      sumFCR = 0;
      sumSEG = 0;
      sumDIV = 0;
      sumDAR = 0;
      sumSOS = 0;
      sumSUE = 0;

      for (var i = 0; i < txList.length; i++) {
        if (txList[i].type == 'Expense') {
          var newValue = txList[i].amount;
          totalExpenses += newValue;
          if (txList[i].tag == 'FCR') {
            var newValue = txList[i].amount;
            sumFCR += newValue;
          }
          if (txList[i].tag == 'SEG') {
            var newValue = txList[i].amount;
            sumSEG += newValue;
          }
          if (txList[i].tag == 'DIV') {
            var newValue = txList[i].amount;
            sumDIV += newValue;
          }
          if (txList[i].tag == 'DAR') {
            var newValue = txList[i].amount;
            sumDAR += newValue;
          }
          if (txList[i].tag == 'SOS') {
            var newValue = txList[i].amount;
            sumSOS += newValue;
          }
          if (txList[i].tag == 'SUE') {
            var newValue = txList[i].amount;
            sumSUE += newValue;
          }
        }
        if (txList[i].type == 'Income') {
          var newValue = txList[i].amount;
          totalIncomes += newValue;
        }
      }
    }
    notifyListeners();
  }

  double get expenses {
    return totalExpenses;
  }

  double get incomes {
    return totalIncomes;
  }

  double get totalFCR {
    return sumFCR;
  }

  double get totalSEG {
    return sumSEG;
  }

  double get totalDIV {
    return sumDIV;
  }

  double get totalDAR {
    return sumDAR;
  }

  double get totalSOS {
    return sumSOS;
  }

  double get totalSUE {
    return sumSUE;
  }
}
