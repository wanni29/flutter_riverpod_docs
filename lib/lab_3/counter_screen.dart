import 'package:flutter/material.dart';
import 'package:flutter_provider_lab/lab_3/provider/counter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageId = 'MSG_123';

    // 창고관리자를 구독하고 변화 감지 중점
    final countProvider = ref.watch(counterProvider(messageId));

    // 창고관리자에게 창고데이터를 변경할것을 요청하는 게 중점
    final countNotifier = ref.read(counterProvider(messageId).notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Family with StateNotifer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Message ID : ${countProvider.messageId}'),
            const SizedBox(height: 10),
            Text(
              'Count : ${countProvider.count}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: countNotifier.increment,
                  child: const Text("Increment"),
                ),
                ElevatedButton(
                  onPressed: countNotifier.decrement,
                  child: const Text("Decrement"),
                ),
                ElevatedButton(
                  onPressed: countNotifier.reset,
                  child: const Text("Reset"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
