import 'package:flutter/material.dart';
import 'package:flutter_provider_lab/lab_4/provider/counter_provider.dart';
import 'package:flutter_provider_lab/lab_4/provider/greeting_provider.dart';
import 'package:flutter_provider_lab/lab_4/provider/is_even_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ObserverTestScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태를 감시
    final count = ref.watch(counterProvider);
    // 짝수 여부 확인
    final isEven = ref.watch(isEvenProvider);
    // family 이름 전달하기
    final greeting = ref.watch(greetingProvider('Riverpod User'));

    return Scaffold(
      appBar: AppBar(
        title: const Text('ObserverTest Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter : $count'),
            Text('Is Even : $isEven'),
            Text(greeting),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => ref.read(counterProvider.notifier).increment(),
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () => ref.read(counterProvider.notifier).decrement(),
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
