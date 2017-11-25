import 'dart:async';
import 'package:Flexer/util/time_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeRepository {

  static const String KEY_TOTAL_DURATION = "TotalDuration.key";
  static const String KEY_LAST_DURATION = "LastDuration.key";
  static const String KEY_LAST_DURATION_DATE = "LastDurationDate.key";

  static final TimeRepository _singleton = new TimeRepository._internal();

  TimeRepository._internal();

  factory TimeRepository() {
    return _singleton;
  }

  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Future<Duration> getTotalDuration() async {
    return _getDuration(KEY_TOTAL_DURATION);
  }

  Future<bool> setTotalDuration(Duration duration) async {
    return _setDuration(KEY_TOTAL_DURATION, duration);
  }

  /// Returns last duration today or null if missing
  Future<Duration> getLastDurationToday() async {
    return _getDuration(KEY_LAST_DURATION)
        .then((duration) {
        return _getLastDurationDate()
            .then((dateTime) {
          if (dateTime != null && TimeUtils.isToday(dateTime)) {
            return duration;
          } else {
            return new Duration();
          }
        });
    });
  }

  Future<bool> setLastDurationToday(Duration duration) async {
    return _setDuration(KEY_LAST_DURATION, duration)
    .then((ignored) => _setLastDurationDate());
  }

  /// Returns duration or null if missing
  Future<Duration> _getDuration(String key) async {
    return prefs.then((prefs) => prefs.getInt(key))
        .then((millis) {
      return millis != null ? new Duration(milliseconds: millis)
          : new Duration();
    });
  }

  Future<bool> _setDuration(String key, Duration duration) async {
    return SharedPreferences.getInstance()
        .then((prefs) {
      prefs.setInt(key, duration.inMilliseconds);
      prefs.commit();
    });
  }

  /// Returns date of last duration or null if missing
  Future<DateTime> _getLastDurationDate() {
    return prefs.then((prefs) => prefs.getInt(KEY_LAST_DURATION_DATE))
        .then((millis) {
      return millis != null ? new DateTime.fromMillisecondsSinceEpoch(millis)
          : null;
    });
  }

  Future<bool> _setLastDurationDate() {
    return SharedPreferences.getInstance()
        .then((prefs) {
      prefs.setInt(
          KEY_LAST_DURATION_DATE, new DateTime.now().millisecondsSinceEpoch);
      prefs.commit();
    });
  }
}