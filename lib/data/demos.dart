import '../models/activity.dart';

class Demos {
  static List<Activity> activities() {
    return <Activity>[
      Activity(
        id: '1',
        title: 'Demo 1',
        description: 'Donec vehicula egestas accumsan. Vivamus vel condimentum odio. Nullam sed tristique sapien.',
        startDate: DateTime(2023, 02, 05, 12),
        attendees: 10,
      ),
      Activity(
        id: '2',
        title: 'Demo 2',
        description: 'Donec vehicula egestas accumsan. Vivamus vel condimentum odio. Nullam sed tristique sapien.',
        startDate: DateTime(2023, 02, 08, 13, 05),
        attendees: 2,
      ),
      Activity(
        id: '3',
        title: 'Demo 3',
        description: 'Donec vehicula egestas accumsan. Vivamus vel condimentum odio. Nullam sed tristique sapien.',
        startDate: DateTime(2023, 03, 22, 08, 02),
        attendees: 7,
      ),
      Activity(
        id: '4',
        title: 'Demo 4',
        description: 'Donec vehicula egestas accumsan. Vivamus vel condimentum odio. Nullam sed tristique sapien.',
        startDate: DateTime(2023, 06, 10, 22, 15),
        attendees: 6,
      ),
    ];
  }
}
