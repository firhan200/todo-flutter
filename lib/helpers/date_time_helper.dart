import 'package:intl/intl.dart';

class DateTimeHelper {
  static String format = 'd MMM, EEEE';

  static String getFormattedDate(DateTime date) {
    String formattedTime = DateFormat(format).format(date);

    return formattedTime;
  }

  static DateTime getDateByFormattedString(String dateString) {
    DateTime dateTime = DateFormat(format).parse(dateString);

    return dateTime;
  }
}
