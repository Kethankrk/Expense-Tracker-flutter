import 'dart:convert';

import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/widgets/data_class.dart';
import 'package:expense_tracker/widgets/expense_insert_card.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const MaterialApp(
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
      appBar: AppBar(
        title: const Text('hello'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
              onPressed: _openModal,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: Home(listFromStorage: _finalList),
    );
  }
}
