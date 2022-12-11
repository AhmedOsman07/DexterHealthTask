class TodoModel {
  TodoModel({
    required this.nurseID,
    required this.state,
    required this.residenceName,
    required this.timestamp,
    required this.date,
    required this.taskTitle,
    required this.residenceID,
    this.id,
    this.shiftID,
  });

  TodoModel.empty();

  TodoModel.fromJson(Map<String, Object?> json, String id)
      : this(
          id: id,
          date: json['date']! as String,
          nurseID: json['nurseID']! as String,
          taskTitle: json['taskTitle']! as String,
          state: json['state']! as String,
          timestamp: json['timestamp'] as int,
          residenceID: json['residenceID'] as String,
          residenceName: json['residenceName'] as String,
          // taskID: json['taskID']! as String,
        );

  String? id;
  int? timestamp;
  String? nurseID;
  String? state;
  String? residenceName;

  // String? taskID;
  String? taskTitle;
  String? shiftID;
  String? shiftTypeID;
  String? shiftTitle;
  String? residenceID;
  String? residenceTitle;
  String? date;

  Map<String, Object?> toJson() {
    return {
      'nurseID': nurseID,
      'state': state,
      "timestamp": timestamp,
      "taskTitle": taskTitle,
      "date": date,
      'shiftID': shiftID,
      'residenceID': residenceID,
      'residenceName': residenceName,
    };
  }
}
