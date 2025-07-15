import 'package:flutter/cupertino.dart';
import 'package:to_do_list/data/model/todo.dart';
import 'package:to_do_list/domain/repositories/todo_repositories.dart';

class TodoViewModel extends ChangeNotifier{
  late final TodoRepositories todoRepositories;  // só leitura
  List<String> _todos = [];
  List<String> get todos => _todos;

  Future<void> addTodo(Todo todo) async {
    print('Adicionando: ${todo.title}');
    await todoRepositories.addTodo(todo); // aguarda o salvamento
    _todos = await todoRepositories.getTodos(); // atualiza lista local
    notifyListeners();
  }


  void getEveryTodo() async {
    _todos = await todoRepositories.getTodos();
    print('Recebidos do repositório: $todos');
    notifyListeners();
  }
}