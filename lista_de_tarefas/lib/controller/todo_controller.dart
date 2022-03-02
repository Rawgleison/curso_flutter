import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo.dart';

const todoListKey = 'todo_list';

class TodoController {
  Future<List<Todo>> getTodoList() async {
    prefs = await SharedPreferences.getInstance();
    final String jsonTodoList = prefs.getString(todoListKey) ?? '[]';
    final List jsonDecoded = json.decode(jsonTodoList) as List;
    return jsonDecoded.map((e) => Todo.fromJoson(e)).toList();
  }

  late SharedPreferences prefs;

  void saveTodoList(List<Todo> todos) {
    final jsonString = json.encode(todos);
    prefs.setString(todoListKey, jsonString);
  }
}
