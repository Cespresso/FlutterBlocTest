import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/data/todo.dart';

class InputTodoWidget extends StatefulWidget{

  final Todo formData;
  final Function onSubmit;

  const InputTodoWidget({Key key, this.formData, this.onSubmit}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _InputTodoWidget();
}

class _InputTodoWidget extends State<InputTodoWidget>{

  Todo _formData;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _formData = widget.formData;
  }

  Widget _buildTitleTextField(String initTitle) {
    // TextFormFieldはFormWidgetの中において使い、Formに渡したkeyがsaveされるとonSaveが呼ばれる
    return TextFormField(
      initialValue: initTitle,
      decoration: InputDecoration(
        labelText: "タイトル",
      ),
      validator: (String text) {
        // TODO バリデーション
      },
      onSaved: (String text) {
        _formData.title = text;
      },
    );
  }

  Widget _buildBodyTextField(String initBody) {
    return TextFormField(
      initialValue: initBody,
      decoration: InputDecoration(
        labelText: "本文",
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
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          _buildTitleTextField(widget.formData.title),
          _buildBodyTextField(widget.formData.body),
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
                // 親のウィジェットから指摘された処理を実行する
                widget.onSubmit(_formData);
              },
            ),
          )
        ],
      ),
    );
  }
}