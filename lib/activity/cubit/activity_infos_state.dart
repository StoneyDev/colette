part of 'activity_infos_cubit.dart';

abstract class ActivityInfosState {
  ActivityInfosState({this.nbRegistrations = 0, this.remainingPlaces = 0});

  final int nbRegistrations;
  final int remainingPlaces;
}

class ActivityLoading extends ActivityInfosState {}

class ActivitySubscriber extends ActivityInfosState {
  ActivitySubscriber({super.nbRegistrations, super.remainingPlaces});
}

class ActivityUnsubscriber extends ActivityInfosState {
  ActivityUnsubscriber({super.nbRegistrations, super.remainingPlaces});
}

class SubscribeSuccess extends ActivityInfosState {}

class UnsubscribeSuccess extends ActivityInfosState {}

class ActivityFailed extends ActivityInfosState {}
