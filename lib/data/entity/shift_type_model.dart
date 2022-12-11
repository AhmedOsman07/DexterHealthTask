class ShiftType {
  ShiftType({
    required this.id,
    required this.title,
    required this.startTime,
    required this.endTime,
  });

  ShiftType.fromJson(Map<String, Object?> json, String id)
      : this(
          id: id,
          title: json['title']! as String,
          endTime: json['endTime']! as String,
          startTime: json['startTime']! as String,
        );

  late String? id;
  late String? title;
  late String? startTime;
  late String? endTime;

  toJson() {
    return {};
  }
}
