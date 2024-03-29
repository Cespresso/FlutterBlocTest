import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/dart/todo_bloc.dart';
import 'package:flutter_bloc_test/dart/todo_bloc_provider.dart';
import 'package:flutter_bloc_test/data/todo.dart';
import 'package:flutter_bloc_test/widgets/input_todo_widget.dart';

class AddTodoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_AddTodoPageState();
}
class _AddTodoPageState extends State<AddTodoPage> {
  Todo _formData = Todo.genWithUniqueID("", "");

  @override
  Widget build(BuildContext context) {
    TodoBloc bloc = TodoBlocProvider.of(context);
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              pinned: false,
              actions: <Widget>[
                // TODO 削除ボタンの追加
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text("新規追加"), // TODO todoのタイトル
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: InputTodoWidget(
                  formData: _formData,
                  onSubmit: (Todo todo){
                    bloc.todoAddition.add(todo);
                    Navigator.pop(context, "/");
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
