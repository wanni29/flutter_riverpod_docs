import 'package:flutter_provider_lab/lab_2/model/todo.dart';
import 'package:flutter_provider_lab/lab_2/provider/filter_provider.dart';
import 'package:flutter_provider_lab/lab_2/provider/todo_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 창고 관리자 - todoListProvider 와 filterProvider를 이용하여 데이터를 가공 후 사용
final filterdTodoListProvider = Provider<List<Todo>>(
  (ref) {
    final filter = ref.watch(filterProvider); // 현재 필터 읽기
    final todos = ref.watch(todoListProvider); // 할 일 목록 읽기

    switch (filter) {
      case Filter.none:
        return todos;
      case Filter.completed:
        return todos.where((todo) => todo.completed).toList();
      case Filter.uncompleted:
        return todos.where((todo) => !todo.completed).toList();
    }
  },
);
