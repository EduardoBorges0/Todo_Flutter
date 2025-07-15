import '../../data/model/todo.dart';

abstract class TodoRepositories {
  Future<void> addTodo(Todo todo);
  Future<void> removeTodoByKey(int key);
  Future<List<Todo>> getTodos();
  Future<void> updateTodoByKey(int key, String newTodo);
  Future<void> updateIsDoneByKey(int key, bool isDone);

}