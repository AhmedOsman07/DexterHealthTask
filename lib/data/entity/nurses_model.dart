class NurseModel {
  NurseModel({
    required this.name,
    required this.completedTasks,
    required this.pendingTasks,
  });

  NurseModel.fromJson(Map<String, Object?> json, String id)
      : this(
          name: json['name']! as String,
          completedTasks: json['completedTasks']! as int,
          pendingTasks: json['pendingTasks']! as int,
        );

  late String? name;
  late int? completedTasks;
  late int? pendingTasks;

  toJson() {}
}
