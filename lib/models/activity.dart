class Activity {
  const Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.attendees,
  });

  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final int attendees;
}
