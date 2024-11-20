import 'package:flutter_provider_lab/lab_2/model/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 창고 관리자 - StateNotifierProvider : 창고관리자를 통하여 창고에 접근할수있음
final todoListProvider =
    StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

// 창고 - StateNotifier :  데이터를 가공하며, 상태관리를 하는 책임이 있다.
class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([]);

  // 할 일 추가
  void addTodo(Todo todo) {
    // 기존에 있는 TodoList 들고오고
    // 새로 들어오는 todo 매개변수를 기존에 있는거에 추가하는 로직
    state = [...state, todo];
  }

  // 할 일 완료/미완료 상태 토글
  void toggleCompleted(int index) {
    // 오잉? state안에서 데이터를 가공 할 수가 있네?
    // 토글 버튼을 누르게 되면 toggleCompleted 메소드가 동작하고
    // 해당되는 인덱스 번호를 가진 todo의 completed 필드값을 반대로 변경
    // 해당되지 않는 인덱스 번호라면 그대로
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index)
          Todo(title: state[i].title, completed: !state[i].completed)
        else
          state[i],
    ];
  }
}
