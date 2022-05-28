import 'package:flutter/material.dart';
import 'package:todo_flutter/presentation/todo_form.dart';
import 'package:todo_flutter/presentation/todo_screen.dart';

import 'model/todo.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch(settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => TodoScreen(name: args.toString(),));
      case '/form':
        if (args != null) {
          var todo = args as Todo;
          return MaterialPageRoute(builder: (_) => TodoForm(id: todo.id, todo: todo.todo, content: todo.description,));
        } else {
          return MaterialPageRoute(builder: (_) => TodoForm());
        }
      default:
        return null;
    }
  }
}