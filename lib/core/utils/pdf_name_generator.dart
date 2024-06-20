import 'package:intl/intl.dart';

String pdfNameGenerator(String organizerName) {
  DateFormat dateFormat =
      DateFormat('[dd-MMMM-yyyy] Kegiatan ${organizerName.trim()}', 'id');
  return dateFormat.format(DateTime.now());
}
