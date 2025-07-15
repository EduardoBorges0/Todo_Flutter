import 'package:flutter/cupertino.dart';
import 'package:to_do_list/data/model/todo.dart';
import 'package:to_do_list/domain/repositories/todo_repositories.dart';

class TodoViewModel extends ChangeNotifier{
  late final TodoRepositories todoRepositories;  // só leitura
  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  int? _editingIndex;
  int? get editingIndex => _editingIndex;

  void setEditingIndex(int? index) {
    _editingIndex = index;
    notifyListeners();
  }

  Future<void> addTodo(Todo todo) async {
    await todoRepositories.addTodo(todo);
    _todos = await todoRepositories.getTodos();
    notifyListeners();
  }

  void getEveryTodo() async {
    _todos = await todoRepositories.getTodos();
    notifyListeners();
  }

  void updateTodoByKey(int key, String newTodo) async {
    await todoRepositories.updateTodoByKey(key, newTodo);
    _todos = await todoRepositories.getTodos();
    notifyListeners();
  }

  void updateIsDone(int key, bool isDone) async {
    await todoRepositories.updateIsDoneByKey(key, isDone);
    _todos = await todoRepositories.getTodos();
    notifyListeners();
  }

  void removeTodoByKey(int key) async {
    await todoRepositories.removeTodoByKey(key);
    _todos = await todoRepositories.getTodos();
    notifyListeners();
  }
}