import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/widgets/data_class.dart';

final formatter = DateFormat.yMd();

class ExpenseAddModal extends StatefulWidget {
  const ExpenseAddModal({super.key, required this.addExpense});

  final void Function(ExpenseData) addExpense;

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

  void submitHandle() {
    if (_title.text.trim() == "" ||
        double.parse(_amount.text) <= 0 ||
        _pickedDateTime == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                    'Please make sure all the field are filled with proper data!'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'))
                ],
              ));
      return;
    }

    widget.addExpense(ExpenseData(_title.text, double.parse(_amount.text),
        _pickedDateTime!, _selectedCategory));

    Navigator.pop(context);
  }

  @override
  Widget build(context) {
    return Container(
      color: const Color.fromARGB(255, 26, 26, 26),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              maxLength: 50,
              decoration: const InputDecoration(
                  label: Text("Title", style: TextStyle(color: Colors.white)),
                  hintText: "Travel expense",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(179, 192, 192, 192))),
              controller: _title,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                    controller: _amount,
                    decoration: const InputDecoration(
                      label: Text(
                        'Amount',
                        style: TextStyle(color: Colors.white),
                      ),
                      prefix: Text('₹ ', style: TextStyle(color: Colors.white)),
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
                      Text(
                          _pickedDateTime == null
                              ? 'No date selected'
                              : formatter.format(_pickedDateTime!),
                          style: const TextStyle(color: Colors.white)),
                      IconButton(
                        onPressed: _openDatePicker,
                        icon: const Icon(Icons.calendar_month,
                            color: Colors.white),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            DropdownButton(
                style: const TextStyle(color: Colors.white),
                dropdownColor: const Color.fromARGB(255, 29, 29, 29),
                value: _selectedCategory,
                items: Categories.values
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e.name,
                          ),
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
                ElevatedButton(
                    onPressed: submitHandle, child: const Text('Submit'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
