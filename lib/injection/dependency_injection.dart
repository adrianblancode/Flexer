import 'package:Flexer/data/time_repository.dart';


enum Flavor {
  MOCK,
  DEFAULT
}

/// Simple DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure({Flavor flavor: Flavor.DEFAULT}) {
    _flavor = flavor;
  }

  factory Injector() {
    return _singleton;
  }

  Injector._internal();

  TimeRepository get timeRepository {
    return new TimeRepository();
  }
}