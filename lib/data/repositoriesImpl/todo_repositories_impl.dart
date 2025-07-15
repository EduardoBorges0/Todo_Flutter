
import 'dart:ffi';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_list/data/model/todo.dart';

import '../../domain/repositories/todo_repositories.dart';

class TodoRepositoriesImpl extends TodoRepositories{
  static const String boxName = 'todoBox';

  Future<Box<Todo>> _getBox() async {
    return await Hive.openBox<Todo>(boxName);
  }

  @override
  Future<int> addTodo(Todo todo) async {
    final box = await _getBox();
    return box.add(todo);
  }

  @override
  Future<List<Todo>> getTodos() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<void> removeTodoByKey(int key) {
    final box = _getBox();
    return box.then((b) => b.delete(key));
  }

  @override
  Future<void> updateTodoByKey(int key, String newTodo) async {
    final box = await _getBox();
    return box.put(key, Todo(title: newTodo));
  }

  @override
  Future<void> updateIsDoneByKey(int key, bool isDone) async {
    final box = await _getBox();
    return box.put(key, Todo(title: box.get(key)!.title, isDone: isDone));
  }
}