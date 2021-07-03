import 'package:flutter/material.dart';
import 'package:my_money/screens/add_record.dart';
import 'package:my_money/screens/home_screen.dart';
import 'package:my_money/screens/tx_list.dart';
import 'package:my_money/models/transaction.dart';
import 'package:my_money/constants.dart';

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
  double totalIncomes = 0;
  double totalExpenses = 0;
  Icon selectedIcon = Icon(Icons.forward);

  void _addNewTx(String title, String tag, double amount, String type) {
    var newTx = Transaction(
      title: title,
      tag: tag,
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
      type: type,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
    totalIncomes = 0;
    totalExpenses = 0;
    for (var i = 0; i < _userTransactions.length; i++) {
      if (_userTransactions[i].type == 'Expense') {
        // selectedIcon = Icon(Icons.forward, color: Colors.red);
        var newValue = _userTransactions[i].amount;
        totalExpenses += newValue;
        print(_userTransactions[i].type);
      }
      if (_userTransactions[i].type == 'Income') {
        // selectedIcon = Icon(Icons.forward, color: Colors.green);
        var newValue = _userTransactions[i].amount;
        totalIncomes += newValue;
        print(_userTransactions[i].type);
      }
    }
    newAmount.clear();
    newConcept.clear();
    newBudget.clear();
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
      totalExpenses = 0;
      for (var i = 0; i < _userTransactions.length; i++) {
        var txValue = _userTransactions[i].amount;
        totalExpenses += txValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      HomeScreen(
        totalExpenses: totalExpenses,
        totalIncomes: totalIncomes,
      ),
      TxList(
        transactions: _userTransactions,
        deleteTx: _deleteTx,
        // icon: selectedIcon,
      ),
      TxList(
        transactions: _userTransactions,
        deleteTx: _deleteTx,
        // icon: selectedIcon,
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
                icon: Icon(
                  Icons.add_circle_rounded,
                  size: 50,
                ),
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
