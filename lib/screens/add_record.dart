import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/models/transaction.dart';
import 'package:my_money/widgets/buttons_add_record.dart';
import 'package:my_money/widgets/main_textfield.dart';
import 'package:my_money/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = FirebaseFirestore.instance;
User? loggedInUser;

// ignore: must_be_immutable
class AddRecord extends StatefulWidget {
  late Function addTx;

  AddRecord(this.addTx);

  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  DateTime dateTime = DateTime.now();

  final Map<int, Widget> children = const <int, Widget>{
    0: Text('Expense'),
    1: Text('Income'),
  };

  final Map<int, Widget> incomeType = const <int, Widget>{
    0: Text('Active Income'),
    1: Text('Pasive Income'),
  };

  int? incomeTypeVal = 1;
  int? currentValue = 0;
  String budgetTag = 'IA';

  void _submitData() {
    if (double.parse(newAmount.text).isNegative) {
      return;
    }
    if (currentValue == 0) {
      budgetTag = newBudget.text;
    }
    if (currentValue == 1) {
      incomeTypeVal == 0 ? budgetTag = 'AI' : budgetTag = 'PI';
    }

    widget.addTx(newConcept.text, budgetTag, double.parse(newAmount.text),
        dateTime, currentValue == 0 ? 'Expense' : 'Income');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Widget makeDismissible({required Widget child}) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: child,
        ),
      );
    }

    Widget buildDatePicker() => SizedBox(
          height: 150,
          child: CupertinoDatePicker(

              // backgroundColor: Colors.white,
              initialDateTime: dateTime,
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: DateTime(DateTime.now().year, 2, 1),
              maximumDate: DateTime.now(),
              onDateTimeChanged: (dateTime) {
                setState(() {
                  this.dateTime = dateTime;
                });
              }),
        );

    return makeDismissible(
      child: DraggableScrollableSheet(
        initialChildSize: 0.95,
        maxChildSize: 0.95,
        builder: (context, controller) => Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
          child: ListView(
            controller: controller,
            children: [
              CupertinoSlidingSegmentedControl(
                thumbColor: currentValue == 0 ? Colors.red : Colors.green,
                children: children,
                onValueChanged: (int? value) {
                  setState(() {
                    currentValue = value;
                  });
                },
                groupValue: currentValue,
              ),
              SizedBox(height: 30),
              MainTextField(
                controller: newAmount,
                prefixIcon:
                    Icon(Icons.attach_money_rounded, color: Colors.black),
                hintText: 'Enter Amount',
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmit: _submitData,
              ),
              SizedBox(
                height: 30,
              ),
              MainTextField(
                controller: newConcept,
                prefixIcon: Icon(Icons.notes_rounded, color: Colors.black),
                hintText: 'Enter Concept',
                keyboardType: TextInputType.name,
                onSubmit: _submitData,
              ),
              SizedBox(
                height: 30,
              ),
              if (currentValue == 0)
                MainTextField(
                  controller: newBudget,
                  prefixIcon:
                      Icon(Icons.all_inbox_rounded, color: Colors.black),
                  hintText: 'Enter Budget',
                  keyboardType: TextInputType.name,
                  onSubmit: _submitData,
                ),
              if (currentValue == 1)
                CupertinoSlidingSegmentedControl(
                  children: incomeType,
                  onValueChanged: (int? value) {
                    setState(() {
                      incomeTypeVal = value;
                    });
                  },
                  groupValue: incomeTypeVal,
                ),
              if (currentValue == 1) SizedBox(height: 30),
              if (currentValue == 0) SizedBox(height: 30),
              buildDatePicker(),
              SizedBox(height: 30),
              Container(
                width: 300,
                child: Row(
                  children: [
                    ButtonAddRecord(
                      color: Colors.black12,
                      title: 'Cancel',
                      onPress: () {
                        newAmount.clear();
                        newConcept.clear();
                        newBudget.clear();
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(width: 15),
                    ButtonAddRecord(
                      color: Theme.of(context).accentColor,
                      title: 'Add',
                      onPress: () {
                        // _fireStore.collection("messages").orderBy(false);
                        newAmount.clear();
                        newConcept.clear();
                        newBudget.clear();
                        Navigator.pop(context);

                        _fireStore.collection("tx").add({
                          'title': newConcept.text,
                          'tag': newBudget.text,
                          'amount': double.parse(newAmount.text),
                          'date': DateTime.now().microsecondsSinceEpoch,
                          'id':
                              DateTime.now().microsecondsSinceEpoch.toString(),
                          'type': currentValue == 0 ? 'Expense' : 'Income',
                        });

                        // _submitData();
                        print('add');
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
