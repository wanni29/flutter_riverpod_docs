import 'package:flutter_riverpod/flutter_riverpod.dart';

// 창고 관리자
final counterProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

// 창고 (복잡한 model 상태를 관리하는것 뿐만아니라, 기본형의 상태도 관리가 되는구나)
class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  // 상태 증가
  void increment() => state++;

  // 상태 감소
  void decrement() => state--;
}
