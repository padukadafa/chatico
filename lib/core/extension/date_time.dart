import 'package:intl/intl.dart';

extension Format on DateTime {
  String differentFromNow() {
    final now = DateTime.now();
    if (now.difference(DateTime.now().copyWith(day: 22)).inDays < 1) {
      return DateFormat('hh:mm').format(this);
    }
    if (now.difference(this).inDays < 7) {
      return DateFormat('EEE').format(this);
    }
    final dayThisMonth = DateTime(now.year, now.month)
        .difference(DateTime(now.year, now.month + 1))
        .inDays;
    if (now.difference(this).inDays < dayThisMonth) {
      return DateFormat('dd').format(this);
    }
    final dayBeforeEndYear = now.difference(DateTime(now.year + 1)).inDays;
    if (now.difference(this).inDays < 365 + dayBeforeEndYear) {
      return DateFormat('dd MMM').format(this);
    }
    return DateFormat('yyyy').format(this);
  }
}
