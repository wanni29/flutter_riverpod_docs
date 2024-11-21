import 'package:flutter/material.dart';
import 'package:flutter_provider_lab/lab_1/part_watch.dart';
import 'package:flutter_provider_lab/lab_1/total_watch.dart';
import 'package:flutter_provider_lab/lab_2/combine_watch.dart';
import 'package:flutter_provider_lab/lab_3/counter_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // lab_1 test case
      // home: TotalWatch(),
      // home: PartWatch(),

      // lab_2 test case
      // home: TodoScreen(),

      // lab_3 test case
      home: CounterScreen(),
    );
  }
}
