import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:main/models/todo.dart';
import 'package:main/views/widgets/add_todo_dialog.dart';
import 'package:main/views/widgets/custom_drawer.dart';
import 'package:main/views/widgets/todo_search_delegate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TodoAppScreens extends StatefulWidget {
  const TodoAppScreens({super.key});

  @override
  State<TodoAppScreens> createState() => _TodoAppScreensState();
}

class _TodoAppScreensState extends State<TodoAppScreens> {
  List<TodoApp> todos = [];
  List<TodoApp> filteredTodos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  void _addOrEditTodo([TodoApp? todo]) {
    showDialog(
      context: context,
      builder: (ctx) => TodoAppAdd(
        todoApp: todo,
        onSave: (newTodo) {
          setState(() {
            if (todo == null) {
              todos.add(newTodo);
            } else {
              final index = todos.indexOf(todo);
              todos[index] = newTodo;
            }
          });
        },
      ),
    );
  }

  void _deleteTodo(TodoApp todo) {
    setState(() {
      todos.remove(todo);
    });
  }

  void _updateSearchResults(List<TodoApp> results) {
    setState(() {
      filteredTodos = results;
    });
  }

  void _loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTodos = prefs.getString('todos');
    if (savedTodos != null) {
      setState(() {
        todos = (json.decode(savedTodos) as List)
            .map((item) => TodoApp.fromJson(item))
            .toList();
        filteredTodos = todos;
      });
    }
  }

  void _saveTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = json.encode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString('todos', todosJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.todo,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: TodoSearchDelegate(todos, _updateSearchResults),
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (ctx, index) {
          final todo = todos[index];
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: ListTile(
                leading: IconButton(
                  icon: Icon(
                    todo.isCompleted
                        ? Icons.check_box
                        : Icons.check_box_outline_blank_outlined,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    setState(() {
                      todo.isCompleted = !todo.isCompleted;
                    });
                  },
                ),
                title: Text(
                  todo.title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                subtitle: Text(
                  todo.description,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blue.shade700,
                      ),
                      onPressed: () => _addOrEditTodo(todo),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red.shade700,
                      ),
                      onPressed: () => _deleteTodo(todo),
                    ),
                  ],
                ),
                onTap: () => _addOrEditTodo(todo),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            Theme.of(context).floatingActionButtonTheme.backgroundColor,
        onPressed: () => _addOrEditTodo(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
