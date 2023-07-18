import 'dart:convert';

import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/widgets/data_class.dart';
import 'package:expense_tracker/widgets/expense_insert_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final formatter = DateFormat.yMd();
void main() {
  runApp(const  MaterialApp(
    home: ParentContainer(),
  ));
}

class ParentContainer extends StatefulWidget {
  const ParentContainer({super.key});

  @override
  State<ParentContainer> createState() {
    return _ParentContainerState();
  }
}

class _ParentContainerState extends State<ParentContainer> {
  List<ExpenseData> _finalList = [];

  double totalExpenseFinder() {
    double totalExpense = 0;
    final tempList = _finalList.where((element) =>
        formatter.format(DateTime.now()) == formatter.format(element.dateTime));
    for (final items in tempList) {
      totalExpense += items.expense;
    }
    return totalExpense;
  }

  @override
  void initState() {
    void retriveDataFromLocalStorage() async {
      SharedPreferences pref = await SharedPreferences.getInstance();
      if (!pref.containsKey('expenseList')) return;

      String encodedList = pref.getString('expenseList')!;
      List<dynamic> decodedList = jsonDecode(encodedList);

      setState(() {
        _finalList = decodedList.map((e) => ExpenseData.fromJson(e)).toList();
      });
    }

    retriveDataFromLocalStorage();
    super.initState();
  }

  void addToFinalList(ExpenseData data) {
    setState(() {
      _finalList.add(data);
      setToLocalStorage(_finalList);
    });
  }

  void setToLocalStorage(List<ExpenseData> localData) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String encodedList = jsonEncode(localData.map((e) => e.toJson).toList());
    pref.setString('expenseList', encodedList);
  }

  void clearLocalStorage() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('expenseList');

    setState(() {
      _finalList.clear();
    });
  }

  void _openModal() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => ExpenseAddModal(
        addExpense: addToFinalList,
      ),
    );
  }

  @override
  Widget build(ctx) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 37, 37, 37),
      appBar: AppBar(
        title: const Text('Expense  Tracker', style: TextStyle(color: Colors.white),),
        backgroundColor: const Color.fromARGB(255, 65, 65, 65),
        actions: [
          IconButton(
              onPressed: _openModal,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30, bottom: 25),
            child: Text(
              "Expenses",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),
          Expanded(
            child: Home(
                listFromStorage: _finalList, totalExpense: totalExpenseFinder),
          ),
          const SizedBox(
            height: 30,
          ),
          OutlinedButton(
              onPressed: clearLocalStorage,
              child: const Text('Clear Expenses')),
          const SizedBox(
            height: 20,
          ),
          Text(
            "₹ ${totalExpenseFinder().toString()}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }
}
