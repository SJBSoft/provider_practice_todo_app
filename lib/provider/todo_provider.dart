import 'package:flutter/cupertino.dart';

import '../model/todo_model.dart';

class TodoProvider extends ChangeNotifier{
  final List<TodoModel> _todoList = [];
  List<TodoModel> get allTodoList => _todoList;

  void addTodoList(TodoModel todoModel){
    _todoList.add(todoModel);
    notifyListeners();
  }
  void removeTodoList(TodoModel todoModel){
    final index = _todoList.indexOf(todoModel);
    _todoList.removeAt(index);
    notifyListeners();
  }
  void todoStatusChange(TodoModel todoModel){
    final _index = _todoList.indexOf(todoModel);
    _todoList[_index].toggleCompleted();
    notifyListeners();
  }
}