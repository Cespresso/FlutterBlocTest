import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/dart/todo_bloc.dart';

class TodoBlocProvider extends InheritedWidget {
  final TodoBloc todoBloc;

  TodoBlocProvider({
    @required Widget child,
    @required this.todoBloc,
  }) : super(child: child);

  static TodoBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TodoBlocProvider)
            as TodoBlocProvider)
        .todoBloc;
  }

  @override
  bool updateShouldNotify(TodoBlocProvider oldWidget) =>
      todoBloc != oldWidget.todoBloc;
}
