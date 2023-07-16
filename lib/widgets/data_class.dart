import 'package:intl/intl.dart';

enum Categories { food, travel, work, leisure }

final formatter = DateFormat.yMd();

class ExpenseData {
  const ExpenseData(this.title, this.expense, this.dateTime, this.category);

  final String title;
  final double expense;
  final DateTime dateTime;
  final Categories category;

  String get getFormatedDate {
    return formatter.format(dateTime);
  }
}

var expenseList = [
  ExpenseData('milk', 28.5, DateTime.now(), Categories.food),
  ExpenseData('Rice', 100, DateTime.now(), Categories.food),
  ExpenseData('Biscut', 32.5, DateTime.now(), Categories.food),
  ExpenseData('Meat', 210, DateTime.now(), Categories.food),
];
