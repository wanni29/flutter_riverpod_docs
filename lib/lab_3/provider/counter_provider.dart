import 'package:flutter_provider_lab/lab_3/model/counter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// family의 역할은 창고관리자에게 매개변수를 준다음
// 창고관리자 그 값을 창고에서 원하는데로 데이터를 가공한 후
// UI쪽에서 사용되게 만든다.

// 창고 관리자 - StateNotifierProvider
final counterProvider =
    StateNotifierProvider.autoDispose.family<CounterNotifier, Counter, String>(
  (ref, messageId) {
    ref.onDispose(() {
      print('CounterProvider with messageId $messageId disposed');
    });
    return CounterNotifier(messageId);
  },
);

// 창고 - StateNotifier
class CounterNotifier extends StateNotifier<Counter> {
  CounterNotifier(String messageId)
      : super(Counter(count: 0, messageId: messageId));

  void increment() {
    state = state.copyWith(count: state.count + 1);
  }

  void decrement() {
    state = state.copyWith(count: state.count - 1);
  }

  void reset() {
    state = state.copyWith(count: 0);
  }
}
