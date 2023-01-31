import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/demos.dart';
import '../../models/activity.dart';
import '../../models/user.dart';

part 'activity_state.dart';

class ActivityCubit extends Cubit<ActivityState> {
  ActivityCubit({required this.user}) : super(ActivityInitial()) {
    getActivities();
    getUserActivities();
  }

  final User user;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> getActivities() async {
    emit(ActivityLoading());

    try {
      final List<Activity> allActivities = Demos.activities();

      emit(
        ActivityLoaded(
          allActivities: allActivities,
        ),
      );
    } catch (_) {
      emit(ActivityError());
    }
  }

  Future<void> getUserActivities() async {
    if (state is ActivityLoaded) {
      // Get old state
      final ActivityLoaded oldState = state as ActivityLoaded;

      // Get activities
      final List<Activity> allActivities = Demos.activities();

      // Init SharedPreferences
      final SharedPreferences prefs = await _prefs;

      // Get user's activities
      final List<String>? userActivitiesResponse = prefs.getStringList('userActivities-${user.id}');

      // Filter activities
      final List<Activity> userActivities = allActivities
          .where(
            (Activity activity) => (userActivitiesResponse ?? []).contains(activity.id),
          )
          .toList();

      emit(
        ActivityLoaded(
          allActivities: oldState.allActivities,
          userActivities: userActivities,
        ),
      );
    }
  }
}
