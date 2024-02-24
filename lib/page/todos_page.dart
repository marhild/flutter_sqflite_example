import 'package:flutter/material.dart';

import '../database/todo_db.dart';
import '../model/todo.dart';
import '../widget/create_todo_widget.dart';

class TodosPage extends StatefulWidget {
  const TodosPage({super.key});

  @override
  State<StatefulWidget> createState() => _TodosPageState();
}

class _TodosPageState extends State<TodosPage> {
  Future<List<Todo>>? futureTodos;
  final todoDB = TodoDB();

  @override
  void initState() {
    super.initState();
    fetchTodos();
  }

  void fetchTodos() {
    setState(() {
      futureTodos = todoDB.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('ToDo List'),
    ),
    floatingActionButton: FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => CreateTodoWidget(
            onSubmit: (title) async {
              await todoDB.create(title: title);
              if(!mounted) return;
              fetchTodos();
              Navigator.of(context).pop();
            },
          ),
        );
      },
    ),

  );
}