import 'package:expense_tracker/widgets/card_list.dart';
import 'package:expense_tracker/widgets/data_class.dart';
import 'package:expense_tracker/widgets/empty_list_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

class Home extends StatelessWidget {
  const Home({super.key, required this.listFromStorage, required this.totalExpense});

  final List<ExpenseData> listFromStorage;
  final double Function() totalExpense;

  String getDateTime(){
    return formatter.format(DateTime.now());
  }

  Iterable<ExpenseData> getFilterdList(){
    String todayDate = getDateTime(); 
    return listFromStorage.where((element) => formatter.format(element.dateTime) == todayDate);
  }

  @override
  Widget build(context) {
    if (getFilterdList().isEmpty) return const EmptyList();
    List<ExpenseData> locaList = List.from(getFilterdList());
    return SizedBox(
      child: ListView.builder(
        itemCount: locaList.length,
        itemBuilder: (ctx, index) {
          if (formatter.format(locaList[index].dateTime) ==
              getDateTime()) {
            return CardList(
                title: locaList[index].title,
                expense: locaList[index].expense,
                time: locaList[index].getFormatedDate);
          }
          return const Text('kik');
        },
      ),
    );
  }
}
