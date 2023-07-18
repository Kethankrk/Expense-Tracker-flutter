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

  Color getColors(double value){
    if(value > 1000){
      return const Color.fromARGB(255, 139, 10, 10);
    }
    else if(value > 500){
      return const Color.fromARGB(255, 161, 123, 9);
    }
    else{
      return const Color.fromARGB(255, 4, 139, 9);
    }
  }

  @override
  Widget build(context) {
    return Card(
      color: getColors(expense),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            Text(title, style: const TextStyle(color: Colors.white)),
            Row(
              children: [
                Text(
                  "₹ ${expense.toString()}",
                  style: const TextStyle(color: Colors.white)
                ),
                const Spacer(),
                Text(time, style: const TextStyle(color: Colors.white))
              ],
            )
          ],
        ),
      ),
    );
  }
}
