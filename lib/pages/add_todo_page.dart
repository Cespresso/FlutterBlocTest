import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/dart/todo_bloc.dart';
import 'package:flutter_bloc_test/dart/todo_bloc_provider.dart';
import 'package:flutter_bloc_test/data/todo.dart';

class AddTodoPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>_AddTodoPageState();
}
class _AddTodoPageState extends State<AddTodoPage> {
  Todo _formData = Todo.genWithUniqueID("", "");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildTitleTextField() {
    // TextFormFieldはFormWidgetの中において使い、Formに渡したkeyがsaveされるとonSaveが呼ばれる
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Produce Title",
      ),
      validator: (String text) {
        // TODO バリデーション
      },
      onSaved: (String text) {
        _formData.title = text;
      },
    );
  }

  Widget _buildBodyTextField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Produce Description",
      ),
      maxLines: 4,
      validator: (String text) {
        // TODO バリデーション
      },
      onSaved: (String text) {
        _formData.body = text;
      },
    );
  }

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
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      _buildTitleTextField(),
                      _buildBodyTextField(),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                          textColor: Colors.white,
                          color: Colors.lightGreen,
                          child: Text("保存"),
                          onPressed: () {
                            if (!_formKey.currentState.validate()) {
                              // バリデーションを行って一つでも失敗なら保存処理を行わない
                              return;
                            }
                            _formKey.currentState.save();
                            bloc.todoAddition.add(_formData);
                            Navigator.pop(context, "/");
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
//            SliverList(
//              delegate: SliverChildListDelegate(
//                <Widget>[
//                  _buildTitleTextField(),
//                  _buildBodyTextField(),
//                  SizedBox(
//                    height: 10,
//                  ),
//                  RaisedButton(
//                    child: Text("保存"),
//                    onPressed: () {
//                      if (!_formKey.currentState.validate()) {
//                        // バリデーションを行って一つでも失敗なら保存処理を行わない
//                        return;
//                      }
//                      _formKey.currentState.save();
//                      bloc.todoAddition.add(_formData);
//                      Navigator.pushReplacementNamed(context, "/");
//                    },
//                  )
//                ],
//              ),
//            )
//          SliverToBoxAdapter　// Sliverの普通のWidgetを置くよう
//            child: Container(
//              child: Text("TODO ここにフォームを作る"),
//            ),
//          )
          ],
        ),
      ),
    );
  }
}
