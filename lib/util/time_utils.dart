import 'package:intl/intl.dart';

class TimeUtils {

  static DateTime atStartOfDay(DateTime dateTime) {
    return new DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return atStartOfDay(a).isAtSameMomentAs(atStartOfDay(b));
  }

  static bool isToday(DateTime dateTime) {
    return isSameDay(dateTime, new DateTime.now());
  }

  static String formatDuration(Duration time, {bool forcePrefix: false}) {

    if (time == null) {
      return "00:00";
    }

    NumberFormat _formatter = new NumberFormat('00');

    int hours = time.inHours.abs();
    int minutes = time.inMinutes.abs() % 60;
    String prefix = _getTimePrefix(time, forcePrefix);

    return '$prefix${_formatter.format(hours)}:${_formatter.format(minutes)}';
  }

  static String _getTimePrefix(Duration time, bool forcePrefix) {
    if (time.inHours == 0 && time.inMinutes == 0) {
      return "";
    } else if (time.isNegative) {
      return "-";
    } else {
      return forcePrefix ? "+" : "";
    }
  }
}