import 'package:flutter/material.dart';
import 'package:my_money/widgets/home_card.dart';
import 'package:my_money/widgets/main_cards.dart';
import 'package:my_money/constants.dart';

class HomeScreen extends StatelessWidget {
  static const id = 'home_screen';

  double totalIncomes = 0;
  double totalExpenses = 0;

  HomeScreen({required this.totalExpenses, required this.totalIncomes});

  @override
  Widget build(BuildContext context) {
    double myBalance = totalIncomes - totalExpenses;

    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20, top: 30),
                child: Hero(
                  tag: 'logo',
                  child: Icon(
                    Icons.monetization_on_rounded,
                    size: 120,
                  ),
                ),
              ),
              SizedBox(
                width: 200,
                child: Divider(),
              ),
              Text(
                'My Money',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
                child: Divider(),
              ),
              HomeCard(
                title: 'My Balance',
                icon: Icons.account_balance_wallet_rounded,
                iconColor: Colors.black,
                value: myBalance,
              ),
              SizedBox(
                height: 20,
              ),
              HomeCard(
                title: 'Incomes',
                icon: Icons.arrow_circle_down_rounded,
                iconColor: Colors.black,
                value: totalIncomes,
              ),
              SizedBox(
                height: 20,
              ),
              HomeCard(
                  title: 'Expenses',
                  icon: Icons.arrow_circle_up_rounded,
                  iconColor: Colors.black,
                  value: totalExpenses),
            ],
          ),
        ),
      ),
    );
  }
}
