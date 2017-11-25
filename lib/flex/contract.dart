import 'dart:async';

abstract class FlexViewContract {
  void onTimesReceived(Duration totalTime, Duration todayTime);
}

abstract class FlexPresenterContract {
  void loadTime();
  void onAddTimeClicked();
  void onRemoveTimeClicked();
}

abstract class FlexModelContract {

  Future<Duration> getTotalDuration();

  Future<bool> setTotalDuration(Duration duration);

  Future<Duration> getDurationToday();

  Future<bool> setDurationToday(Duration duration);
}