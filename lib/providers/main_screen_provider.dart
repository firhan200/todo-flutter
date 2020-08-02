import 'package:blog/helpers/todo_db_helper.dart';
import 'package:blog/models/todo.dart';
import 'package:flutter/foundation.dart';

class MainScreenProvider with ChangeNotifier {
  DateTime _selectedDate = DateTime.now();
  List<Todo> _todoOnDay = List<Todo>();
  bool _isListLoading = true;

  TodoProvider _todoProvider = new TodoProvider();

  MainScreenProvider() {
    getTasksByDay(_selectedDate);
  }

  bool get isListLoading => _isListLoading;
  set isListLoading(bool isLoading) {
    _isListLoading = isLoading;
    notifyListeners();
  }

  /* selected date getter and setter */
  DateTime get getSelectedDate => _selectedDate;
  set setSelectedDate(DateTime dateTime) {
    _selectedDate = dateTime;
    notifyListeners();

    getTasksByDay(dateTime);
  }

  void addTodo(String title, String subtitle, DateTime dateTime) async {
    Todo todo = Todo(title, subtitle, dateTime, false);

    await _todoProvider.insert(todo);

    getTasksByDay(getSelectedDate);
  }

  void removeTodo(Todo todo) async {
    await _todoProvider.delete(todo.id);

    getTasksByDay(getSelectedDate);
  }

  void setCompleted(int todoId, bool isCompleted) async {
    //get todo
    Todo todo = await _todoProvider.getTodo(todoId);
    if (todo != null) {
      todo.isCompleted = isCompleted;
      await _todoProvider.update(todo);

      getTasksByDay(_selectedDate);
    }
  }

  /* selected date getter and setter */
  List<Todo> get getTodoOnDay => _todoOnDay;
  void setTodoOnDay(List<Todo> todoOnDay) {
    _todoOnDay = todoOnDay;
    notifyListeners();
  }

  void getTasksByDay(DateTime selectedDate) async {
    //set is loading
    isListLoading = true;

    _selectedDate = selectedDate;

    var value = await _todoProvider.getTodoByDate(selectedDate);
    setTodoOnDay(value);
    //set is loading
    isListLoading = false;
  }
}
