import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/dart/todo_bloc.dart';
import 'package:flutter_bloc_test/dart/todo_bloc_provider.dart';
import 'package:flutter_bloc_test/data/todo.dart';

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

Widget _buildScrollWidget(TodoBloc bloc, List<Todo> todos) {
  return CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 250.0,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text("TODO"),
        ),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            Todo todo = todos[index];
            if (todo.isCompleted) {
              return ListTile(
                leading: IconButton(
                    icon: Icon(Icons.check_box),
                    onPressed: () {
                      todo.isCompleted = false;
                      bloc.todoEdit.add(todo);
                    }),
                title: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed("/todo/edit/"+todo.id.toString());
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      todo.title,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              );
            }
            return ListTile(
              leading: IconButton(
                  icon: Icon(Icons.check_box_outline_blank),
                  onPressed: () {
                    todo.isCompleted = true;
                    bloc.todoEdit.add(todo);
                  }),
              title: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/todo/edit/"+todo.id.toString());
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    todo.title,
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            );
          },
          childCount: todos.length,
        ),
      )
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
          builder: (BuildContext context, AsyncSnapshot<List<Todo>> snap) {
//            if (snap.connectionState == ConnectionState.done) {
////              if (snap.hasError) {
////                return Center(
////                  child: Text("エラーです"),
////                );
////              }
//
//            }
            if (snap.hasData) {
              return _buildScrollWidget(bloc, snap.data);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).pushNamed("/todo/add");
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
