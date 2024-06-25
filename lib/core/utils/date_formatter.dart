import 'package:intl/intl.dart';

String formatDateTime({required String dateTimeString, bool isIndonesia = true}) {
  if (dateTimeString == '') {
    return dateTimeString;
  }

  DateTime dateTime = DateTime.parse(dateTimeString);

  DateFormat dateFormat = DateFormat('dd MMMM yyyy HH:mm', 'ID');

  String formattedDate = dateFormat.format(dateTime);

  return formattedDate;
}
