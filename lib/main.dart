import 'package:flutter/material.dart';
import 'package:flutter_provider_lab/lab_1/part_watch.dart';
import 'package:flutter_provider_lab/lab_1/total_watch.dart';
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
      home: TotalWatch(),
      // home: PartWatch(),
    );
  }
}
