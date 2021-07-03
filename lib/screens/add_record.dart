import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_money/models/transaction.dart';
import 'package:my_money/widgets/buttons_add_record.dart';
import 'package:my_money/widgets/main_textfield.dart';
import 'package:my_money/constants.dart';

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

  int? currentValue = 0;

  void _submitData() {
    if (double.parse(newAmount.text).isNegative) {
      return;
    }
    widget.addTx(newConcept.text, newBudget.text, double.parse(newAmount.text),
        currentValue == 0 ? 'Expense' : 'Income');
    Navigator.of(context).pop();
  }

  void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              'Done',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: onClicked,
          ),
        ),
      );

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
          height: 300,
          child: CupertinoDatePicker(
              backgroundColor: Colors.white,
              initialDateTime: dateTime,
              mode: CupertinoDatePickerMode.date,
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
              SizedBox(
                height: 30,
              ),
              CupertinoButton(
                  color: Colors.black12,
                  child: Text('Enter Date'),
                  onPressed: () {
                    showSheet(
                      context,
                      child: buildDatePicker(),
                      onClicked: () => Navigator.pop(context),
                    );
                  }),
              if (currentValue == 0) SizedBox(height: 30),
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
                        _submitData();
                        print('add');
                        newAmount.clear();
                        newConcept.clear();
                        newBudget.clear();
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
