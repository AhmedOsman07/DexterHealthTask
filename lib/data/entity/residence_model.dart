import 'package:nursing_home_dexter/data/entity/selection_contract.dart';

class ResidentsModel extends SelectionContract {
  ResidentsModel({
    required this.name,
    required this.residentsTasks,
    required this.id,
    required this.shiftType,
  });

  ResidentsModel.fromJson(Map<String, Object?> json, String id)
      : this(
            id: id,
            name: json['name']! as String,
            shiftType: (json['shiftType'] as List<dynamic>).map((e) => e as String).toList(),
            residentsTasks: (json['tasks'] as List<dynamic>)
                .map((e) => ResidentsTasks.fromJson(e, ""))
                .toList());

  late String? id;
  late String? name;
  late List<ResidentsTasks>? residentsTasks;
  late List<String>? shiftType;

  toJson() {
    return {};
  }

  @override
  String? getSubtitle() {
    return null;
  }

  @override
  String getID() {
    return id!;
  }

  @override
  String getName() {
    return name!;
  }

  @override
  List<Object?> get props => [id];
}

class ResidentsTasks extends SelectionContract {
  ResidentsTasks({
    this.id,
    required this.shiftType,
    required this.title,
  });

  toJson() {
    return {"shiftType": shiftType, "title": title};
  }

  ResidentsTasks.fromJson(Map<String, Object?> json, String id)
      : this(
            id: id,
            title: json['title']! as String,
            shiftType: (json['shiftType'] as List<dynamic>).map((e) => e as String).toList());

  late List<String>? shiftType;
  late String? title;
  late String? id;

  @override
  List<Object?> get props => [id];

  @override
  String? getSubtitle() {
    return null;
  }

  @override
  String getID() {
    return id!;
  }

  @override
  String getName() {
    return title!;
  }
}
