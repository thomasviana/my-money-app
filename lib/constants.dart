import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

final currency = NumberFormat("#,##0.00", "en_US");

TextEditingController newAmount = TextEditingController();
TextEditingController newConcept = TextEditingController();
TextEditingController newBudget = TextEditingController();

const kTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
const kTagTextStyle = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.bold,
);
const kAmountTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
