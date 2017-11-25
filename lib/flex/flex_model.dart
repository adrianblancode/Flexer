import 'dart:async';

import 'package:Flexer/data/time_repository.dart';
import 'package:Flexer/injection/dependency_injection.dart';

class FlexModelImpl {

  TimeRepository _timeRepository;
  FlexModelImpl() {
    _timeRepository = new Injector().timeRepository;
  }

  Future<Duration> getTotalDuration() async {
    return _timeRepository.getTotalDuration();
  }

  Future<bool> setTotalDuration(Duration duration) async {
    return _timeRepository.setTotalDuration(duration);
  }

  Future<Duration> getLastDuration() async {
    return _timeRepository.getLastDurationToday();
  }

  Future<bool> setLastDuration(Duration duration) async {
    return _timeRepository.setLastDurationToday(duration);
  }
}