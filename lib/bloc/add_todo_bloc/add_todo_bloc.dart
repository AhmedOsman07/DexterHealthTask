import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nursing_home_dexter/data/entity/shift_type_model.dart';
import 'package:nursing_home_dexter/data/entity/todo_model.dart';

import '../../data/FirebaseRepo.dart';
import '../../data/entity/enum.dart';
import '../../data/entity/residence_model.dart';
import '../../data/entity/shifts_model.dart';
import '../../main.dart';
import '../../shared/utils/user_singelton.dart';

part 'add_todo_event.dart';

part 'add_todo_state.dart';

class AddTodoBloc extends Bloc<AddTodoEvent, AddTodoState> {
  List<ShiftsModel>? shiftListForNurse;
  List<ResidentsModel>? residenceList;
  Map<String, ShiftType>? shiftTypes;

  // int? selectedShiftTypeIndex;
  int? selectedResidenceTypeIndex;
  int? selectedTaskTypeIndex;

  AddTodoBloc() : super(AddTodoInitial()) {
    on<AddTodo>(_addModel);
    on<FetchDataEvent>(_fetchData);
    on<UpdateTodoListEvent>(_updateTodoList);
    on<ApplyTodoFilterEvent>(_selectRes);
  }

  FutureOr<void> _addModel(AddTodo event, Emitter<AddTodoState> emit) async {
    emit(LoadingAddTodoState());
    final now = DateTime.now();

    if (event.shouldAddNewTask) {
      int index = (residenceList!.indexOf(ResidentsModel(
          name: "", residentsTasks: [], id: event.model.residenceID, shiftType: [])));

      if (index != -1 &&
          !(residenceList![index].shiftType!.contains("${event.model.shiftTypeID}"))) {
        List<String>? list = residenceList![index].shiftType;
        list!.add(event.model.shiftTypeID!);
        await FirebaseRepo()
            .residentsTypesRef
            .doc(event.model.residenceID)
            .update({"shiftType": list});
      }

      List<ResidentsTasks>? tasks = residenceList![index].residentsTasks;

      tasks!
          .add(ResidentsTasks(shiftType: [event.model.shiftTypeID!], title: event.model.taskTitle));
      FirebaseRepo()
          .residentsTypesRef
          .doc(event.model.residenceID)
          .update({"tasks": tasks.map((e) => e.toJson()).toList()});
    }
    TodoModel model = TodoModel(
        nurseID: AppSingleton.getInstance.user!.uid,
        state: "Pending",
        shiftID: event.model.shiftTypeID,
        timestamp: DateTime.now().millisecondsSinceEpoch,
        date: dateFormat.format(now),
        taskTitle: event.model.taskTitle,
        residenceID: event.model.residenceID,
        residenceName: event.model.residenceName);

    int count = AppSingleton.getInstance.data!.pendingTasks! + 1;
    AppSingleton.getInstance.data!.pendingTasks = count;
    FirebaseRepo()
        .nursesRef
        .doc(AppSingleton.getInstance.user!.uid)
        .update({"pendingTasks": count});

    await FirebaseRepo().todoListRef.add(model).then((value) async {
      model.id = value.id;
      // model.shiftTitle = event.model.
      emit(AddToDoSuccess(model));
    });
  }

  FutureOr<void> _fetchData(FetchDataEvent event, Emitter<AddTodoState> emit) async {
    final now = DateTime.now();

    await FirebaseRepo().shiftTypesRef.get().then((value) {
      shiftTypes = <String, ShiftType>{};
      for (var element in value.docs) {
        shiftTypes![element.id] = element.data();
      }
    });

    await FirebaseRepo()
        .shiftsRef
        .where('date', isGreaterThanOrEqualTo: dateFormat.format(now))
        .where('nurseID', isEqualTo: (AppSingleton.getInstance.user!.uid))
        .get()
        .then((value) {
      shiftListForNurse = [];
      for (var element in value.docs) {
        var item = element.data();
        var shiftType = shiftTypes![item.shiftType];
        item.shiftEndTime = shiftType!.endTime!;
        item.shiftStartTime = shiftType.startTime!;
        item.shiftTitle = shiftType.title;
        shiftListForNurse!.add(item);
      }
    });

    await FirebaseRepo()
        .residentsTypesRef
        // .where("shiftType", arrayContainsAny: ["3"])
        .get()
        .then((value) {
      residenceList = [];
      for (var element in value.docs) {
        residenceList!.add(element.data());
      }
    });
    emit(FetchedListsSuccess());
  }

  FutureOr<void> _selectRes(ApplyTodoFilterEvent event, Emitter<AddTodoState> emit) async {
    switch (event.filterType) {
      case TodoFilterEnum.shiftType:
        selectedResidenceTypeIndex = event.index;
        emit(UpdateAvailableTasks());
        break;
      case TodoFilterEnum.residentsName:
        selectedResidenceTypeIndex = event.index;
        emit(UpdateAvailableTasks());
        break;
    }
  }

  FutureOr<void> _updateTodoList(UpdateTodoListEvent event, Emitter<AddTodoState> emit) async {
    emit(FetchedListsSuccess());
  }
}
