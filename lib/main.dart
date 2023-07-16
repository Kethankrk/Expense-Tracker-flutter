import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/widgets/expense_insert_card.dart';
import 'package:flutter/material.dart';

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
  void _openModal() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const ExpenseAddModal(),
    );
  }

  @override
  Widget build(ctx) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('hello'),
        backgroundColor: Colors.green,
        actions: [
          IconButton(onPressed: _openModal, icon: const Icon(Icons.add, color: Colors.white,))
        ],
      ),
      body: const Home(),
    );
  }
}
