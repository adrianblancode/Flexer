import 'dart:async';

import 'package:Flexer/data/time_repository.dart';
import 'package:Flexer/flex/contract.dart';
import 'package:Flexer/injection/dependency_injection.dart';

class FlexModelImpl implements FlexModelContract {

  TimeRepository _timeRepository;
  FlexModelImpl() {
    _timeRepository = new Injector().timeRepository;
  }

  @override
  Future<Duration> getTotalDuration() async {
    return _timeRepository.getTotalDuration();
  }

  @override
  Future<bool> setTotalDuration(Duration duration) async {
    return _timeRepository.setTotalDuration(duration);
  }

  @override
  Future<Duration> getDurationToday() async {
    return _timeRepository.getDurationToday();
  }

  @override
  Future<bool> setDurationToday(Duration duration) async {
    return _timeRepository.setDurationToday(duration);
  }
}