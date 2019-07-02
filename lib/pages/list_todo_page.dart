import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/dart/todo_bloc.dart';
import 'package:flutter_bloc_test/dart/todo_bloc_provider.dart';

class ListTodoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListTodoPage();
}

Widget _makeAddBottomSheet() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        child: TextFormField(),
        padding: EdgeInsets.all(8.0),
      ),
      Container(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: double.infinity,
          child: FlatButton(
            textColor: Colors.white,
            color: Colors.lightGreen,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0)),
            ),
            onPressed: () {},
            child: Text("Add"),
          ),
        ),
      ),
    ],
  );
}

class _ListTodoPage extends State<ListTodoPage> {
  @override
  Widget build(BuildContext context) {
    TodoBloc bloc = TodoBlocProvider.of(context);
    return Scaffold(
      body: StreamBuilder(
          stream: bloc.todos,
          initialData: bloc.todos.value,
          builder: (BuildContext context, AsyncSnapshot snap) {
            if (snap.connectionState == ConnectionState.done) {
              if (snap.hasError) {
                return Center(
                  child: Text("エラーです"),
                );
              }
              return Center(
                child: Text(
                  snap.data.toString(),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed("/add");
        },
        label: Text("Add Task"),
        icon: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
