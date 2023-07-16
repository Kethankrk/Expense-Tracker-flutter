import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/widgets/data_class.dart';

final formatter = DateFormat.yMd();

class ExpenseAddModal extends StatefulWidget {
  const ExpenseAddModal({super.key});

  @override
  State<ExpenseAddModal> createState() {
    return _ExpenseAddModalState();
  }
}

class _ExpenseAddModalState extends State<ExpenseAddModal> {
  final _title = TextEditingController();
  final _amount = TextEditingController();
  DateTime? _pickedDateTime;
  Categories _selectedCategory = Categories.leisure;

  @override
  void dispose() {
    _title.dispose();
    _amount.dispose();
    super.dispose();
  }

  void _openDatePicker() async {
    final newDate = DateTime.now();
    final oldDate = DateTime(newDate.year - 1, newDate.month, newDate.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: oldDate,
        lastDate: newDate);

    setState(() {
      _pickedDateTime = pickedDate;
    });
  }

  @override
  Widget build(context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
              hintText: "Travel expense",
            ),
            controller: _title,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amount,
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    prefix: Text('₹ '),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_pickedDateTime == null
                        ? 'No date selected'
                        : formatter.format(_pickedDateTime!)),
                    IconButton(
                        onPressed: _openDatePicker,
                        icon: const Icon(Icons.calendar_month))
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          DropdownButton(
              value: _selectedCategory,
              items: Categories.values
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ))
                  .toList(),
              onChanged: (val) {
                if (val == null) return;
                setState(() {
                  _selectedCategory = val;
                });
              }),
          Row(
            children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Submit'))
            ],
          )
        ],
      ),
    );
  }
}
