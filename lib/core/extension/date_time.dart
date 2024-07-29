import 'package:intl/intl.dart';

extension Format on DateTime {
  String differentFromNow() {
    final now = DateTime.now();
    if (now.difference(this).inDays < 1) {
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

  String groupedDifferentFromNow() {
    final now = DateTime.now();
    final diff = now.difference(this).inDays;
    if (diff < 1) {
      return "Today";
    }
    if (diff < 7) {
      return DateFormat('EEE').format(this);
    }
    final dayThisMonth = DateTime(now.year, now.month)
        .difference(DateTime(now.year, now.month + 1))
        .inDays;
    if (diff < dayThisMonth) {
      return DateFormat('dd').format(this);
    }
    final dayBeforeEndYear = now.difference(DateTime(now.year + 1)).inDays;
    if (diff < 365 + dayBeforeEndYear) {
      return DateFormat('dd MMM').format(this);
    }
    return DateFormat('yyyy').format(this);
  }
}
