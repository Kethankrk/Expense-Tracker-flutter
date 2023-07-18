
import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({super.key});

  @override
  Widget build(context){
    return const Center(
      child: Text('No Expenses Today', style: TextStyle(color: Colors.white),),
    );
  }
}