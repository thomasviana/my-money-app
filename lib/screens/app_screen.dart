import 'package:flutter/material.dart';
import 'package:my_money/screens/add_record.dart';
import 'package:my_money/screens/home_screen.dart';
import 'package:my_money/screens/tx_list.dart';
import 'package:my_money/models/transaction.dart';

class MainAppScreen extends StatefulWidget {
  @override
  _MainAppScreenState createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 1) {
      setState(() {
        _selectedIndex = 2;
      });
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) => AddRecord(_addNewTx),
      );
    }
  }

  List<Transaction> _userTransactions = [];
  double totalExpenses = 0;

  void _addNewTx(String title, String tag, double amount) {
    var newTx = Transaction(
        title: title, tag: tag, amount: amount, date: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
    totalExpenses = 0;
    for (var i = 0; i < _userTransactions.length; i++) {
      var newValue = _userTransactions[i].amount;
      totalExpenses += newValue;
    }
    newAmount.clear();
    newConcept.clear();
    newBudget.clear();
  }

  void _deleteTx() {
    print('deleting 2');

    setState(() {
      _userTransactions.remove(_userTransactions[1]);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      HomeScreen(totalExpenses: totalExpenses),
      TxList(
        transactions: _userTransactions,
        deleteTx: _deleteTx,
      ),
      TxList(
        transactions: _userTransactions,
        deleteTx: _deleteTx,
      ),
    ];

    print(totalExpenses);

    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_rounded,
                    size: 50, color: Theme.of(context).primaryIconTheme.color),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.format_list_bulleted_rounded),
                label: 'Records'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryIconTheme.color,
          onTap: _onItemTapped),
    );
  }
}
