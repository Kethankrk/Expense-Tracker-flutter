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

  Map<String, dynamic> get toJson{
    return {
      'title' : title,
      'expense' : expense,
      'dateTime': dateTime.toString(),
      'category' : category.toString()
    };
  }


  factory ExpenseData.fromJson(Map<String, dynamic> json){
    Categories strinTocustomEnums(String value){
    switch (value){
      case 'Categories.food':
        return Categories.food;
      case 'Categories.work':
        return Categories.work;
      case 'Categories.leisure':
        return Categories.leisure;
      default:
        return Categories.travel;
    }
  }
    return ExpenseData(json['title'], json['expense'], DateTime.parse(json['dateTime']), strinTocustomEnums(json['category']));
  }
}

