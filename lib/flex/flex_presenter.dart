import 'dart:async';

import 'package:Flexer/flex/contract.dart';
import 'package:Flexer/flex/flex_model.dart';

class FlexPresenterImpl implements FlexPresenterContract {

  static const int TIME_DELTA = 15;

  FlexViewContract _view;
  FlexModelContract _model;

  FlexPresenterImpl(this._view) {
    _model = new FlexModelImpl();
  }

  @override
  loadTime() async {
    _TimeState timeState = await _getTimeInternal();
    _view.onTimesReceived(timeState.totalTime, timeState.timeToday);
  }

  @override
  void onAddTimeClicked() {
    _addTimeInternal(new Duration(minutes: TIME_DELTA));
  }

  @override
  void onRemoveTimeClicked() {
    _addTimeInternal(new Duration(minutes: -TIME_DELTA));
  }

  Future<_TimeState> _getTimeInternal() async {
    Duration totalTime = await _model.getTotalDuration();
    Duration timeToday = await _model.getDurationToday();
    return new _TimeState(totalTime, timeToday);
  }

  _addTimeInternal(Duration time) async {
    _TimeState timeState = await _getTimeInternal();

    Duration totalTime = timeState.totalTime + time;
    Duration timeToday = timeState.timeToday + time;

    _view.onTimesReceived(totalTime, timeToday);

    await _model.setTotalDuration(totalTime);
    await _model.setDurationToday(timeToday);
  }
}

class _TimeState {
  final Duration totalTime;
  final Duration timeToday;

  _TimeState(this.totalTime, this.timeToday);
}