import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/activity.dart';

part 'activity_infos_state.dart';

class ActivityInfosCubit extends Cubit<ActivityInfosState> {
  ActivityInfosCubit({required this.activity, required this.userId}) : super(ActivityUnsubscriber()) {
    isInvolved();
  }

  final Activity activity;
  final String userId;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> subscribe() async {
    try {
      emit(ActivityLoading());

      // Init SharedPreferences
      final SharedPreferences prefs = await _prefs;

      // Get all attendees from this activity
      final List<String>? attendees = prefs.getStringList(activity.id);

      // Get user's activities
      final List<String>? userActivities = prefs.getStringList('userActivities');

      final List<String> newAttendees = <String>[...attendees ?? <String>[], userId];

      // Set the new attendee
      prefs.setStringList(activity.id, newAttendees);

      // Set user activities
      prefs.setStringList('userActivities', <String>[...userActivities ?? <String>[], activity.id]);

      // Show snackabr
      emit(SubscribeSuccess());

      // Change state button
      emit(
        ActivitySubscriber(
          nbRegistrations: newAttendees.length,
          remainingPlaces: activity.attendees - newAttendees.length,
        ),
      );
    } catch (e) {
      emit(ActivityFailed());
    }
  }

  Future<void> isInvolved() async {
    // Init SharedPreferences
    final SharedPreferences prefs = await _prefs;

    // Get all attendees from this activity
    final List<String>? attendees = prefs.getStringList(activity.id);

    if ((attendees ?? <String>[]).contains(userId)) {
      emit(
        ActivitySubscriber(
          nbRegistrations: (attendees ?? []).length,
          remainingPlaces: activity.attendees - (attendees ?? []).length,
        ),
      );
    } else {
      emit(
        ActivityUnsubscriber(
          nbRegistrations: (attendees ?? []).length,
          remainingPlaces: activity.attendees - (attendees ?? []).length,
        ),
      );
    }
  }

  Future<void> unsubscribe() async {
    try {
      emit(ActivityLoading());

      // Init SharedPreferences
      final SharedPreferences prefs = await _prefs;

      // Get all attendees from this activity
      final List<String>? attendees = prefs.getStringList(activity.id);

      final List<String>? userActivities = prefs.getStringList('userActivities');

      // Remove attendee id
      attendees!.removeWhere((String e) => e == userId);

      // Remove activity id
      userActivities!.removeWhere((String e) => e == activity.id);

      // Save new list
      prefs.setStringList(activity.id, attendees);

      // Remove activity id
      prefs.setStringList('userActivities', userActivities);

      emit(UnsubscribeSuccess());

      emit(
        ActivityUnsubscriber(
          nbRegistrations: attendees.length,
          remainingPlaces: activity.attendees - attendees.length,
        ),
      );
    } catch (e) {
      emit(ActivityFailed());
    }
  }
}
