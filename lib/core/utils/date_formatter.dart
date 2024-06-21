import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  if (dateTimeString == '') {
    return dateTimeString;
  }

  DateTime dateTime = DateTime.parse(dateTimeString);

  DateFormat dateFormat = DateFormat('dd MMMM yyyy HH:mm');

  String formattedDate = dateFormat.format(dateTime);

  return formattedDate;
}
