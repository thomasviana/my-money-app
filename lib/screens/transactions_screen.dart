import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_money/widgets/txs_list.dart';
import 'package:provider/provider.dart';
import 'package:my_money/providers/transactions.dart';

import 'package:my_money/models/transaction.dart';
import 'package:my_money/constants.dart';

final _fireStore = FirebaseFirestore.instance;

class TransactionsScreen extends StatefulWidget {
  @override
  _TransactionsScreenState createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Txs>(
        context,
      ).getData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final currency = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TxsList(),
      ),
    );
  }
}
