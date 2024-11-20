// 필터 Enum 정의
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  none,
  completed,
  uncompleted,
}

// 필터 상태를 관리하는 StateProvider
final filterProvider = StateProvider<Filter>((ref) => Filter.none);

// 참 신기하네, Class 타입 뿐만 아니라 Enum 타입도 받을수가 있구나.