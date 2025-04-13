class CalendarEventData<T> {
  final DateTime date;
  final DateTime? startTime;
  final DateTime? endTime;
  final String title;
  final String description;
  final T? event;
  final DateTime? _endDate;

  const CalendarEventData({
    required this.title,
    this.description = "",
    this.event,
    this.startTime,
    this.endTime,
    DateTime? endDate,
    required this.date,
  }) : _endDate = endDate;

  DateTime get endDate => _endDate ?? date;

  Map<String, dynamic> toJson() => {
        "date": date,
        "startTime": startTime,
        "endTime": endTime,
        "event": event,
        "title": title,
        "description": description,
        "endDate": endDate,
      };
}
