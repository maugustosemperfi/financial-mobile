import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class OverviewEvent extends Equatable {
  OverviewEvent([List props = const <dynamic>[]]) : super(props);
}

class HideBalance extends OverviewEvent {
  @override
  String toString() {
    return "HideBalance";
  }
}

class ShowBalance extends OverviewEvent {
  @override
  String toString() {
    return "ShowBalance";
  }
}

class LoadOverview extends OverviewEvent {
  @override
  String toString() {
    return "LoadOverview";
  }
}
