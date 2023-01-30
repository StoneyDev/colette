part of 'activity_cubit.dart';

abstract class ActivityState {
  ActivityState({this.remainingPlaces = 0});

  final int remainingPlaces;
}

class ActivityLoading extends ActivityState {}

class ActivitySubscriber extends ActivityState {
  ActivitySubscriber({super.remainingPlaces});
}

class ActivityUnsubscriber extends ActivityState {
  ActivityUnsubscriber({super.remainingPlaces});
}

class SubscribeSuccess extends ActivityState {}

class UnsubscribeSuccess extends ActivityState {}

class ActivityFailed extends ActivityState {}
