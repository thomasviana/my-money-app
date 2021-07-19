import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'main.dart';

final currency = NumberFormat("#,##0.00", "en_US");
final dateFormat = DateFormat('yyyy-MM-dd');

TextEditingController newAmount = TextEditingController();
TextEditingController newConcept = TextEditingController();
TextEditingController newBudget = TextEditingController();

const kTitleTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);
const kTagTextStyle = TextStyle(fontSize: 15, color: Colors.black54);

const kAmountTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);

const kDateTextStyle = TextStyle(fontSize: 15);

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color.fromRGBO(225, 239, 59, 1), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black54, width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
