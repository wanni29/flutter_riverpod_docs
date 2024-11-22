import 'package:flutter_provider_lab/lab_4/provider/counter_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 짝수를 2로 나누었을때 `0` 이 나온다면 true 값을 반환;
final isEvenProvider = Provider<bool>((ref) {
  final count = ref.watch(counterProvider);
  return count % 2 == 0;
});
