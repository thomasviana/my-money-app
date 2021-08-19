import 'package:flutter/material.dart';

class DateFilter extends StatefulWidget {
  @override
  _DateFilterState createState() => _DateFilterState();
}

class _DateFilterState extends State<DateFilter> {
  var _monthIndex = DateTime.now().month - 1;
  String _selectedMonth = '';

  List months = [
    'January',
    'Febrary',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  void initState() {
    super.initState();
    _selectedMonth = months[_monthIndex];
  }

  void selectMonth(String direction) {
    if (direction == 'back' && _monthIndex > 0 && _monthIndex < 12) {
      setState(() {
        _monthIndex = _monthIndex - 1;
        _selectedMonth = months[_monthIndex];
      });
    } else if (direction == 'forward' && _monthIndex >= 0 && _monthIndex < 11) {
      setState(() {
        _monthIndex = _monthIndex + 1;
        _selectedMonth = months[_monthIndex];
      });
    }
    print(_selectedMonth);
    print(_monthIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      title: Text(_selectedMonth),
      backgroundColor: Colors.grey,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: () {
          selectMonth('back');
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            selectMonth('forward');
          },
          icon: Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}
