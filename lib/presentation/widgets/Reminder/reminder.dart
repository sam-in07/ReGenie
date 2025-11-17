class Reminder {
  final String id;
  final String title;
  final String message;
  final String time;
  final String icon;
  final bool enabled;
  final List<String> days;

  Reminder({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.enabled,
    required this.days,
  });

  Reminder copyWith({bool? enabled}) {
    return Reminder(
      id: id,
      title: title,
      message: message,
      time: time,
      icon: icon,
      enabled: enabled ?? this.enabled,
      days: days,
    );
  }
}
