
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
  Future<List<String>> getTodos() async {
    final box = await _getBox();
    return box.values.map((todo) => todo.title).toList();
  }

  @override
  Future<void> removeTodo(String todo) {
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(String oldTodo, String newTodo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
  
}