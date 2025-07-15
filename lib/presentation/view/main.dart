import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/data/repositoriesImpl/todo_repositories_impl.dart';
import 'package:to_do_list/presentation/view/add_todo.dart';
import 'package:to_do_list/presentation/view/todo_item.dart';
import 'package:to_do_list/presentation/viewModel/todo_view_model.dart';

import '../../data/model/todo.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);

  Hive.registerAdapter(TodoAdapter());
  runApp(
    ChangeNotifierProvider(
      create: (_) {
        final vm = TodoViewModel();
        vm.todoRepositories = TodoRepositoriesImpl();
        return vm;
      },
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TodoScreen(title: 'Flutter Demo Home Page'),
    );
  }
}

class TodoScreen extends StatefulWidget {
  TodoScreen({super.key, required this.title});

  final String title;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TodoViewModel>().getEveryTodo();
    });
  }

  void _editTodo(int index, int? oldIndex) {
    if(index == oldIndex){
      context.read<TodoViewModel>().setEditingIndex(null);
    }else{
      context.read<TodoViewModel>().setEditingIndex(index);
    }
  }


  void _addTodo() {
    final viewModel = context.read<TodoViewModel>();
    final text = _todoController.text.trim();
    if (text.isNotEmpty) {
      viewModel.addTodo(Todo(title: text));
      _todoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoViewModel>();
    final todos = viewModel.todos;
    final editingIndex = viewModel.editingIndex;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (_, index) => TodoItem(
                  todo: todos[index].title,
                  isDone: todos[index].isDone,
                  onIsDone: (isDone) {
                    viewModel.updateIsDone(todos[index].key, isDone!);
                  },
                  onDelete: () => {
                    viewModel.setEditingIndex(null),
                    viewModel.removeTodoByKey(todos[index].key)
                  },
                  isEditing: editingIndex == index,
                  onTap: () => _editTodo(index, editingIndex),
                  onChanged: (newValue) {
                    viewModel.updateTodoByKey(index, newValue);
                  },
                ),
              ),
            ),
            TodoAdd(todoController: _todoController, onAddPressed: _addTodo),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
