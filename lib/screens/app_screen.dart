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

  List<Tx> _userTransactions = [];

  double totalIncomes = 0;
  double totalExpenses = 0;
  Icon selectedIcon = Icon(Icons.forward);

  @override
  void initState() {
    super.initState();
    // updateUI();
  }

  void updateUI() {
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
  }

  void _addNewTx(
      String title, String tag, double amount, String dateTime, String type) {
    var newTx = Tx(
      title: title,
      tag: tag,
      amount: amount,
      date: dateTime,
      id: DateTime.now().toString(),
      type: type,
    );
    setState(() {
      _userTransactions.add(newTx);
    });
    updateUI();
    newAmount.clear();
    newConcept.clear();
    newBudget.clear();
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
      updateUI();
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
          // deleteTx: _deleteTx,
          // icon: selectedIcon,
          ),
      TxList(
          // deleteTx: _deleteTx,
          // icon: selectedIcon,
          ),
    ];

    AppBar txAppBar = AppBar(
      backgroundColor: Theme.of(context).accentColor,
      title: Text('Transactions'),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: _selectedIndex == 2 ? txAppBar : null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
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
          selectedItemColor: Colors.black,
          onTap: _onItemTapped),
    );
  }
}
