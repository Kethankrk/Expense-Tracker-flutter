import 'package:expense_tracker/widgets/card_list.dart';
import 'package:expense_tracker/widgets/data_class.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(context) {
    return SizedBox(
      child: ListView.builder(itemCount: expenseList.length, itemBuilder: (ctx, index) {
        return CardList(title: expenseList[index].title, expense: expenseList[index].expense, time: expenseList[index].getFormatedDate);
      })
    );
  }
}
