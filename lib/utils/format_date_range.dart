import 'package:intl/intl.dart';

String formatTimeRange(DateTime from, DateTime to) {
  // Convert from DateTime to String
  // with format HH:MM - HH:MM Day in week, DD/MM/YYYY
  // assuming from and to are in the same day

  String startTime = DateFormat('kk:mm').format(from);
  String endTime = DateFormat('kk:mm EEE, dd/MM/yyyy').format(to);
  return '$startTime - $endTime';
}
