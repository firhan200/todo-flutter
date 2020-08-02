import 'package:blog/helpers/date_time_helper.dart';
import 'package:blog/helpers/todo_db_helper.dart';

class Todo {
  int id;
  String title, subTitle;
  DateTime dateTime;
  bool isCompleted;

  Todo(this.title, this.subTitle, this.dateTime, this.isCompleted);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnTitle: title,
      columnSubTitle: subTitle,
      columnDateTime: DateTimeHelper.getFormattedDate(dateTime),
      columnIsCompleted: isCompleted == true ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    subTitle = map[columnSubTitle];
    dateTime = DateTimeHelper.getDateByFormattedString(map[columnDateTime]);
    isCompleted = map[columnIsCompleted] == 1;
  }
}
