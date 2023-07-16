import 'package:flutter/material.dart';

class CardList extends StatelessWidget {
  const CardList(
      {super.key,
      required this.title,
      required this.expense,
      required this.time});

  final String title;
  final double expense;
  final String time;

  @override
  Widget build(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(title),
            Row(
              children: [
                Text(
                  "₹${expense.toString()}",
                ),
                const Spacer(),
                Text(time)
              ],
            )
          ],
        ),
      ),
    );
  }
}
