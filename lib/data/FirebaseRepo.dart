import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nursing_home_dexter/data/entity/nurses_model.dart';

import 'entity/residence_model.dart';
import 'entity/shift_type_model.dart';
import 'entity/shifts_model.dart';
import 'entity/todo_model.dart';

class FirebaseRepo {
  final todoListRef = FirebaseFirestore.instance.collection('Tasks').withConverter<TodoModel>(
      fromFirestore: (snapshots, _) {
        return TodoModel.fromJson(snapshots.data()!, snapshots.id);
      },
      toFirestore: (todoObject, _) => todoObject.toJson());

  final shiftsRef = FirebaseFirestore.instance.collection('Shifts').withConverter<ShiftsModel>(
      fromFirestore: (snapshots, _) => ShiftsModel.fromJson(snapshots.data()!, snapshots.id),
      toFirestore: (shiftModel, _) => shiftModel.toJson());
  final shiftTypesRef = FirebaseFirestore.instance
      .collection('ShiftTypes')
      .withConverter<ShiftType>(
          fromFirestore: (snapshots, _) => ShiftType.fromJson(snapshots.data()!, snapshots.id),
          toFirestore: (shiftTypeModel, _) => shiftTypeModel.toJson());
  final residentsTypesRef =
      FirebaseFirestore.instance.collection('Residents').withConverter<ResidentsModel>(
          fromFirestore: (snapshots, _) {
            return ResidentsModel.fromJson(snapshots.data()!, snapshots.id);
          },
          toFirestore: (model, _) => model.toJson());

  final nursesRef = FirebaseFirestore.instance.collection('Users').withConverter<NurseModel>(
      fromFirestore: (snapshots, _) => NurseModel.fromJson(snapshots.data()!, snapshots.id),
      toFirestore: (nurseModel, _) => nurseModel.toJson());
}
