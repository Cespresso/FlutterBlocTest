import 'dart:async';

import 'package:flutter_bloc_test/dart/todo_state.dart';
import 'package:flutter_bloc_test/data/todo.dart';
import 'package:rxdart/rxdart.dart';


class TodoBloc {

  // State
  final TodoState _state = TodoState(List<Todo>());

  // ViewModel
  final BehaviorSubject<List<Todo>> _todosData = BehaviorSubject<
      List<Todo>>.seeded(List<Todo>());

  // ViewModel.InputInterface
  final StreamController<Todo> _todoAdditionController =
      PublishSubject<Todo>();
  final StreamController<Todo> _todoRemovalController =
      PublishSubject<Todo>();
  final StreamController<Todo> _todoEditController =
      PublishSubject<Todo>();

  TodoBloc(){
    // 追加
    _todoAdditionController.stream.listen((data){
      // Stateの変更
      _state.todoList.add(data);
      // 新しいStateをStreamに流す
      _todosData.add(_state.todoList);
    });

    // 削除
    _todoRemovalController.stream.listen((data){
      // Stateの変更
      _state.todoList.removeWhere((item)=>item.id == data.id);
      // 新しいStateをStreamに流す
      _todosData.add(_state.todoList);

    });

    // 編集
    _todoEditController.stream.listen((data){
      // Stateの変更
      List<Todo> newState = _state.todoList.map((item){
        if(item.id == data.id){
          return data;
        }
        return item;
      }).toList();
      // 新しいStateをStreamに流す
      _todosData.add(newState);

    });
  }

  // Stream と　ValueObservableの比較を行う
  ValueObservable<List<Todo>> get todos => _todosData;
  Stream<List<Todo>> get todosStream => _todosData.stream;


  Sink<Todo> get todoAddition => _todoAdditionController.sink;
  Sink<Todo> get todoRemoval => _todoRemovalController.sink;
  Sink<Todo> get todoEdit => _todoEditController.sink;

  void dispose() async {
    await _todosData.close();
    await _todoAdditionController.close();
    await _todoRemovalController.close();
    await _todoEditController.close();
  }
}