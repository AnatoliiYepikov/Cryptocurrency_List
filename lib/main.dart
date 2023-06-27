import 'package:cc_tracker/cc_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CCTracker());
}

class CCTracker extends StatelessWidget {
  const CCTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cryptocurrency List',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const CCList(),
    );
  }
}
