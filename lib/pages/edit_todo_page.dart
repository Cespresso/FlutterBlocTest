import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/dart/todo_bloc.dart';
import 'package:flutter_bloc_test/dart/todo_bloc_provider.dart';
import 'package:flutter_bloc_test/data/todo.dart';
import 'package:flutter_bloc_test/widgets/input_todo_widget.dart';

class EditTodoPage extends StatefulWidget{
  final int id;

  const EditTodoPage({Key key,@required this.id}) : super(key: key);
  @override
  State<StatefulWidget> createState() =>_EditTodoPageState();
}
class _EditTodoPageState extends State<EditTodoPage> {

  @override
  Widget build(BuildContext context) {

    TodoBloc bloc = TodoBlocProvider.of(context);
    Todo todo = bloc.todos.value.firstWhere((item)=>item.id == widget.id);
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
                title: Text("編集"), // TODO todoのタイトル
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: InputTodoWidget(
                  formData: todo,
                  onSubmit: (Todo todo){
                    bloc.todoEdit.add(todo);
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
