part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchingList extends HomeEvent {}

class FetchingWithPagination extends HomeEvent {}

class SetToCompleteEvent extends HomeEvent {
  final String id;

  SetToCompleteEvent(this.id);
}

class AddLocalTodo extends HomeEvent {
  final TodoModel model;

  AddLocalTodo(this.model);
}

class RefereshLocallyEvent extends HomeEvent {
  RefereshLocallyEvent();
}
