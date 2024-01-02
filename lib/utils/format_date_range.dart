const List<String> _dayInWeek = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

const List<String> _Month = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

String formatTimeRange(DateTime from, DateTime to) {
  // Convert from DateTime to String
  // with format HH:MM - HH:MM Day in week, DD/MM/YYYY
  // assuming from and to are in the same day
  String fromString = from.hour.toString().padLeft(2, '0') +
      ':' +
      from.minute.toString().padLeft(2, '0');
  String toString = to.hour.toString().padLeft(2, '0') +
      ':' +
      to.minute.toString().padLeft(2, '0');
  String day = from.day.toString().padLeft(2, '0');
  String month = _Month[from.month - 1];
  String year = from.year.toString();
  String dayInWeek = _dayInWeek[from.weekday - 1];

  return '$fromString - $toString $dayInWeek, $day $month $year';
}
