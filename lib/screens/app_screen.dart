import 'package:flutter/material.dart';
import 'add_record.dart';
import 'home_screen.dart';
import 'tx_list.dart';
import 'settings_screen.dart';
import 'budgets_screen.dart';

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
    if (_selectedIndex == 2) {
      setState(() {
        _selectedIndex = 3;
      });
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: context,
        builder: (context) => AddRecord(),
      );
    }
  }

  double totalIncomes = 0;
  double totalExpenses = 0;
  Icon selectedIcon = Icon(Icons.forward);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _screens = [
      HomeScreen(),
      BudgetsScreen(
        totalExpenses: totalExpenses,
        totalIncomes: totalIncomes,
      ),
      TxList(),
      TxList(),
      SettingsScreen(),
    ];

    AppBar txAppBar = AppBar(
      backgroundColor: Theme.of(context).accentColor,
      leading: Text(''),
      title: Text(
        'Transactions',
        style: TextStyle(color: Colors.black),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: _selectedIndex == 3 ? txAppBar : null,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 12,
          iconSize: 35,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.all_inbox_rounded),
              label: 'Budgets',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_rounded,
                  size: 50,
                ),
                label: ''),
            BottomNavigationBarItem(
              icon: Icon(Icons.format_list_bulleted_rounded),
              label: 'Records',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped),
    );
  }
}
