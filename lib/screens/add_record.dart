import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_money/models/transaction.dart';

TextEditingController newAmount = TextEditingController();
TextEditingController newConcept = TextEditingController();
TextEditingController newBudget = TextEditingController();

// ignore: must_be_immutable
class AddRecord extends StatefulWidget {
  late Function addTx;

  AddRecord(this.addTx);

  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  final Map<int, Widget> children = const <int, Widget>{
    0: Text('Expense'),
    1: Text('Income'),
  };

  int? currentValue = 0;

  void submitData() {
    if (double.parse(newAmount.text).isNegative) {
      return;
    }

    widget.addTx(newConcept.text, newBudget.text, double.parse(newAmount.text));
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
              TextField(
                controller: newAmount,
                cursorColor: Colors.black45,
                autofocus: true,
                style: TextStyle(color: Colors.black),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  hintStyle: TextStyle(color: Colors.black45),
                  prefixIcon: Icon(
                    Icons.attach_money_rounded,
                    color: Colors.black,
                  ),
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                textAlign: TextAlign.center,
                onSubmitted: (_) => submitData(),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: newConcept,
                cursorColor: Colors.black45,
                autofocus: false,
                style: TextStyle(color: Colors.black),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'Enter Concept',
                  hintStyle: TextStyle(color: Colors.black45),
                  prefixIcon: Icon(
                    Icons.notes_rounded,
                    color: Colors.black,
                  ),
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                textAlign: TextAlign.center,
                onSubmitted: (_) => submitData(),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: newBudget,
                cursorColor: Colors.black45,
                autofocus: false,
                style: TextStyle(color: Colors.black),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: 'Enter Budget',
                  hintStyle: TextStyle(color: Colors.black45),
                  prefixIcon: Icon(
                    Icons.all_inbox_rounded,
                    color: Colors.black,
                  ),
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                // controller: newTask,
                textAlign: TextAlign.center,
                onSubmitted: (_) => submitData(),
                keyboardType: TextInputType.name,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 300,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black26,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          fixedSize: Size(0, 55),
                        ),
                        onPressed: () {
                          newAmount.clear();
                          newConcept.clear();
                          newBudget.clear();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          fixedSize: Size(0, 55),
                        ),
                        onPressed: submitData,
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
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
