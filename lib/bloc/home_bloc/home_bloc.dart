import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:nursing_home_dexter/data/FirebaseRepo.dart';

import '../../data/entity/todo_model.dart';
import '../../main.dart';
import '../../shared/utils/user_singelton.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchingList>(fetchTodoList);
    on<FetchingWithPagination>(paginationTodoList);
    on<SetToCompleteEvent>(_setToCompleteEvent);
    on<RefereshLocallyEvent>(_refershLocal);
  }

  int _pageNumber = 1;
  int _limit = 10;

  void resetPage() {
    _pageNumber = 1;
  }

  FutureOr<void> fetchTodoList(FetchingList event, Emitter<HomeState> emit) async {
    final now = DateTime.now();
    await FirebaseRepo()
        .todoListRef
        .where("state", isEqualTo: "Pending")
        .where('date', isLessThan: dateFormat.format(now))
        .get()
        .then((value) async {
      if (value.docs.isNotEmpty) {
        for (var element in value.docs) {
          FirebaseRepo().todoListRef.doc(element.id).update({"date": dateFormat.format(now)});
        }
        emit(HomeSuccessMessage("Successfully moved ${value.docs.length} pending tasks to today"));
      } //ideally we can add view action on toast and show what was moved
    });

    await FirebaseRepo()
        .todoListRef
        .limit(_limit)
        // .endAt([_pageNumber * _limit])
        .where('nurseID', isEqualTo: (AppSingleton.getInstance.user!.uid))
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) async {
      print(value.docs.length);
      emit(HomeListFetched(value.docs, false));
    });
  }

  FutureOr<void> paginationTodoList(FetchingWithPagination event, Emitter<HomeState> emit) async {
    _pageNumber += 1;
    await FirebaseRepo()
        .todoListRef
        .limit(_limit)
        .where('nurseID', isEqualTo: (AppSingleton.getInstance.user!.uid))
        .orderBy('timestamp', descending: true)
        .get()
        .then((value) {
      emit(HomeListFetched(value.docs, true));
    });
  }

  updateTodoList() {}

  FutureOr<void> _setToCompleteEvent(SetToCompleteEvent event, Emitter<HomeState> emit) {
    FirebaseRepo().todoListRef.doc(event.id).update({"state": "Completed"});
    int count = AppSingleton.getInstance.data!.completedTasks! + 1;
    AppSingleton.getInstance.data!.completedTasks = count;
    FirebaseRepo()
        .nursesRef
        .doc(AppSingleton.getInstance.user!.uid)
        .update({"completedTasks": count});
  }

  FutureOr<void> _refershLocal(RefereshLocallyEvent event, Emitter<HomeState> emit) {
    emit(RefreshPageState());
  }
}
