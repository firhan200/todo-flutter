import 'package:blog/helpers/date_time_helper.dart';
import 'package:blog/models/todo.dart';
import 'package:blog/providers/main_screen_provider.dart';
import 'package:blog/widgets/add_todo_form.dart';
import 'package:blog/widgets/per_todo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CalendarController _calendarController;

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[600],
        child: SafeArea(
          child: Container(
            color: Colors.blue[600],
            child: Column(
              children: <Widget>[buildTableCalendar(), buildExpandedContent()],
            ),
          ),
        ),
      ),
    );
  }

  Expanded buildExpandedContent() {
    return Expanded(
        child: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(0), topRight: Radius.circular(50))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildTaskHeader(),
          Consumer<MainScreenProvider>(
            builder: (providerContext, value, child) => Expanded(
              child: Stack(
                children: <Widget>[
                  Visibility(
                    visible: value.isListLoading,
                    child: Center(
                      child: Text('loading'),
                    ),
                  ),
                  Visibility(
                    visible: !value.isListLoading,
                    child: value.getTodoOnDay.length > 0
                        ? buildTodoList(value)
                        : Center(
                            child: Text('No tasks'),
                          ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  Padding buildTaskHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      child: Consumer<MainScreenProvider>(
        builder: (providerContext, value, child) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Tasks',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  DateTimeHelper.getFormattedDate(value.getSelectedDate),
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            FlatButton.icon(
                onPressed: () {
                  showAddTodoBottomSheet(
                      providerContext, value.getSelectedDate);
                },
                icon: Icon(Icons.add),
                label: Text('Add'))
          ],
        ),
      ),
    );
  }

  Widget buildTodoList(MainScreenProvider value) {
    return ListView.builder(
      itemCount: value.getTodoOnDay.length,
      itemBuilder: (context, index) {
        Todo todo = value.getTodoOnDay[index];
        return Dismissible(
            key: ValueKey(todo.id),
            onDismissed: (direction) {
              //remove todo
              value.removeTodo(todo);
            },
            child: PerTodo(todo));
      },
    );
  }

  Widget buildTableCalendar() {
    return Consumer<MainScreenProvider>(
      builder: (context, value, child) => TableCalendar(
        onDaySelected: (day, events) {
          value.setSelectedDate = day;
        },
        startingDayOfWeek: StartingDayOfWeek.monday,
        initialCalendarFormat: CalendarFormat.week,
        availableCalendarFormats: const {
          CalendarFormat.week: '',
        },
        headerStyle: HeaderStyle(
            centerHeaderTitle: true,
            leftChevronIcon: Icon(
              Icons.chevron_left,
              color: Colors.white,
            ),
            rightChevronIcon: Icon(
              Icons.chevron_right,
              color: Colors.white,
            ),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 24)),
        calendarStyle: CalendarStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            selectedColor: Colors.orange,
            markersColor: Colors.white,
            outsideStyle: TextStyle(color: Colors.white)),
        daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.white),
            weekendStyle: TextStyle(color: Colors.white)),
        calendarController: _calendarController,
      ),
    );
  }

  void showAddTodoBottomSheet(BuildContext context, DateTime selectedDateTime) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return AddTodoForm(
            selectedDateTime: selectedDateTime,
          );
        });
  }
}
