import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/dart/todo_bloc.dart';
import 'package:flutter_bloc_test/dart/todo_bloc_provider.dart';
import 'package:flutter_bloc_test/data/todo.dart';
import 'package:flutter_bloc_test/pages/add_todo_page.dart';
import 'package:flutter_bloc_test/pages/edit_todo_page.dart';
import 'package:flutter_bloc_test/pages/list_todo_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_MyAppState();
}

class _MyAppState extends State<MyApp> {
  TodoBloc _todoBloc;

  @override
  void initState() {
    super.initState();
    _todoBloc = TodoBloc();
  }

  @override
  void dispose() {
    super.dispose();
    _todoBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TodoBlocProvider(
      todoBloc: _todoBloc,
      child: MaterialApp(
        routes: {
          "/":(BuildContext context) => ListTodoPage(),
          "/todo/add":(BuildContext context) => AddTodoPage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          final List<String> pathElements = settings.name.split("/");
          if (pathElements[0] != "") {
            return null;
          }
          if (pathElements[1] == "todo" && pathElements[2] == "edit") {
            final int index = int.parse(pathElements[3]);
            return MaterialPageRoute<bool>(
              builder: (BuildContext context) => EditTodoPage(id:index),
            );
          }
          return null;
        },
//      onUnknownRoute: (RouteSettings settings) {
//        return MaterialPageRoute(
//          builder: (BuildContext context) => ScopedModel<TodoModel>(
//            model: widget.todoModel,
//            child: Login(),
//          ),
//        );
//      },
      ),
    );
  }

}
