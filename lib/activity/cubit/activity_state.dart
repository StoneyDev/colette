part of 'activity_cubit.dart';

abstract class ActivityState {
  ActivityState({this.nbRegistrations = 0, this.remainingPlaces = 0});

  final int nbRegistrations;
  final int remainingPlaces;
}

class ActivityLoading extends ActivityState {}

class ActivitySubscriber extends ActivityState {
  ActivitySubscriber({super.nbRegistrations, super.remainingPlaces});
}

class ActivityUnsubscriber extends ActivityState {
  ActivityUnsubscriber({super.nbRegistrations, super.remainingPlaces});
}

class SubscribeSuccess extends ActivityState {}

class UnsubscribeSuccess extends ActivityState {}

class ActivityFailed extends ActivityState {}
