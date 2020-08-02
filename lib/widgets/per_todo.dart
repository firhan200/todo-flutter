import 'package:blog/models/todo.dart';
import 'package:blog/providers/main_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerTodo extends StatefulWidget {
  final Todo todo;

  PerTodo(this.todo);

  @override
  _PerTodoState createState() => _PerTodoState();
}

class _PerTodoState extends State<PerTodo> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
      builder: (context, value, child) => Container(
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 5,
                  offset: Offset(3, 4),
                  color: Colors.grey[200])
            ]),
        child: ListTile(
          title: Text(
            widget.todo.title == null ? '' : widget.todo.title,
            style: TextStyle(
                decoration: widget.todo.isCompleted
                    ? TextDecoration.lineThrough
                    : null),
          ),
          subtitle: Text(
            widget.todo.subTitle == null ? '' : widget.todo.subTitle,
            style: TextStyle(
                decoration: widget.todo.isCompleted
                    ? TextDecoration.lineThrough
                    : null),
          ),
          trailing: Checkbox(
              value: widget.todo.isCompleted,
              onChanged: (newValue) {
                value.setCompleted(widget.todo.id, newValue);
              }),
        ),
      ),
    );
  }
}
