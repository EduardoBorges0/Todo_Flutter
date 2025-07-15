import '../../data/model/todo.dart';

abstract class TodoRepositories {
  Future<void> addTodo(Todo todo);
  Future<void> removeTodo(String todo);
  Future<List<String>> getTodos();
  Future<void> updateTodo(String oldTodo, String newTodo);
}