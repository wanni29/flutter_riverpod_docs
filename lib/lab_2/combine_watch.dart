import 'package:flutter/material.dart';
import 'package:flutter_provider_lab/lab_2/model/todo.dart';
import 'package:flutter_provider_lab/lab_2/provider/filter_provider.dart';
import 'package:flutter_provider_lab/lab_2/provider/filtered_todo_list_provider.dart';
import 'package:flutter_provider_lab/lab_2/provider/todo_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 필터링된 할 일
    final todos = ref.watch(filterdTodoListProvider);
    // 현재 필터
    final filter = ref.watch(filterProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          PopupMenuButton<Filter>(
            onSelected: (value) =>
                ref.read(filterProvider.notifier).state = value,
            itemBuilder: (context) => [
              PopupMenuItem(value: Filter.none, child: Text('All')),
              PopupMenuItem(value: Filter.completed, child: Text('Completed')),
              PopupMenuItem(
                  value: Filter.uncompleted, child: Text('Uncompleted')),
            ],
          )
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];
          return ListTile(
            title: Text(todo.title),
            trailing: Icon(todo.completed ? Icons.check : Icons.close,
                color: todo.completed ? Colors.green : Colors.red),
            onTap: () =>
                ref.read(todoListProvider.notifier).toggleCompleted(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 새로운 할 일 추가
          final todoList = ref.read(todoListProvider.notifier);
          todoList.addTodo(
              Todo(title: 'New Task ${todos.length + 1}', completed: false));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
