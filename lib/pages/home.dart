import 'package:expense_tracker/widgets/card_list.dart';
import 'package:expense_tracker/widgets/data_class.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key, required this.listFromStorage});

  final List<ExpenseData> listFromStorage;

  @override
  Widget build(context) {
    if (listFromStorage.isEmpty) return const Text("no data");
    return SizedBox(
        child: ListView.builder(
            itemCount: listFromStorage.length,
            itemBuilder: (ctx, index) {
              return CardList(
                  title: listFromStorage[index].title,
                  expense: listFromStorage[index].expense,
                  time: listFromStorage[index].getFormatedDate);
            }));
  }
}
