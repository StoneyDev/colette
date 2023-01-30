import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit({required this.activityId, required this.userId}) : super(ActivityUnsubscriber()) {
    isInvolved();
  }

  final String activityId;
  final String userId;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> subscribe() async {
    try {
      emit(ActivityLoading());

      // Init SharedPreferences
      final SharedPreferences prefs = await _prefs;

      // Get all attendees from this activity
      final List<String>? attendees = prefs.getStringList(activityId);

      final List<String> newAttendees = <String>[...attendees ?? <String>[], userId];

      // Set the new attendee
      prefs.setStringList(activityId, newAttendees);

      // Show snackabr
      emit(SubscribeSuccess());

      // Change state button
      emit(ActivitySubscriber(remainingPlaces: newAttendees.length));
    } catch (e) {
      emit(ActivityFailed());
    }
  }

  Future<void> isInvolved() async {
    // Init SharedPreferences
    final SharedPreferences prefs = await _prefs;

    // Get all attendees from this activity
    final List<String>? attendees = prefs.getStringList(activityId);

    if ((attendees ?? <String>[]).contains(userId)) {
      emit(ActivitySubscriber(remainingPlaces: (attendees ?? []).length));
    } else {
      emit(ActivityUnsubscriber(remainingPlaces: (attendees ?? []).length));
    }
  }

  Future<void> unsubscribe() async {
    try {
      emit(ActivityLoading());

      // Init SharedPreferences
      final SharedPreferences prefs = await _prefs;

      // Get all attendees from this activity
      final List<String>? attendees = prefs.getStringList(activityId);

      // Remove attendee id
      attendees!.removeWhere((String e) => e == userId);

      // Save new list
      prefs.setStringList(activityId, attendees);

      emit(UnsubscribeSuccess());

      emit(ActivityUnsubscriber(remainingPlaces: attendees.length));
    } catch (e) {
      emit(ActivityFailed());
    }
  }
}
