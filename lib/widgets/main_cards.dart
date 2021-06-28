import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_money/constants.dart';

class MainCards extends StatelessWidget {
  String? title;
  double? value;
  IconData icon;
  Color iconColor;

  MainCards(
      {this.title, this.value, required this.icon, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 40, horizontal: 18),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 40),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '\$ ${currency.format(value)}',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
