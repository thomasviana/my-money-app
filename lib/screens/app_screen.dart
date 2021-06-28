import 'package:flutter/material.dart';
import 'package:my_money/screens/add_record.dart';
import 'package:my_money/screens/home_screen.dart';
import 'package:my_money/screens/tx_list.dart';

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
        builder: (context) => AddRecord(),
      );
    }
  }

  List<Widget> _screens = [
    HomeScreen(),
    TxList(),
    TxList(),
  ];

  @override
  Widget build(BuildContext context) {
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
