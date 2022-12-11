import 'package:nursing_home_dexter/data/entity/selection_contract.dart';

class ShiftsModel extends SelectionContract {
  ShiftsModel({
    required this.nurseID,
    required this.date,
    required this.shiftType,
    required this.id,
  });

  ShiftsModel.fromJson(Map<String, Object?> json, String id)
      : this(
          id: id,
          nurseID: json['nurseID']! as String,
          date: json['date']! as String,
          shiftType: json['shiftType']! as String,
        );

  late String? id;
  late String? nurseID;
  late String? date;
  late String? shiftType;
  late String? shiftTitle;
  late String? shiftStartTime;
  late String? shiftEndTime;

  Map<String, Object?> toJson() {
    return {
      'nurseID': nurseID,
      'date': date,
      'shiftType': shiftType,
    };
  }

  @override
  String getID() {
    return id!;
  }

  @override
  String getName() {
    return "$shiftTitle ($shiftStartTime-$shiftEndTime)";
  }

  @override
  List<Object?> get props => [id];

  @override
  String? getSubtitle() {
    return "$date";
  }
}
