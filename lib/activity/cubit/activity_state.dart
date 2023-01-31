part of 'activity_cubit.dart';

abstract class ActivityState {}

class ActivityInitial extends ActivityState {}

class ActivityLoading extends ActivityState {}

class ActivityLoaded extends ActivityState {
  ActivityLoaded({
    this.allActivities = const <Activity>[],
    this.userActivities = const <Activity>[],
  });

  final List<Activity> allActivities;
  final List<Activity> userActivities;
}

class ActivityError extends ActivityState {}
