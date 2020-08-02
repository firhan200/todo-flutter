import 'package:blog/providers/main_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoForm extends StatefulWidget {
  final DateTime selectedDateTime;

  AddTodoForm({this.selectedDateTime});

  @override
  _AddTodoFormState createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  String title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenProvider>(
      builder: (providerContext, value, child) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: 300,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Add Task',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Whats to do..'),
              ),
              SizedBox(
                height: 16,
              ),
              TextField(
                onChanged: (value) {
                  setState(() {
                    subTitle = value;
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Details'),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                child: FlatButton.icon(
                    onPressed: () {
                      value.addTodo(title, subTitle, widget.selectedDateTime);

                      //pop
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
