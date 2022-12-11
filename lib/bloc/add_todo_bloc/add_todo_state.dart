part of 'add_todo_bloc.dart';

@immutable
abstract class AddTodoState {}

class AddTodoInitial extends AddTodoState {}

class AddToDoSuccess extends AddTodoState {
  final TodoModel modelAdded;

  AddToDoSuccess(this.modelAdded);
}

class LoadingAddTodoState extends AddTodoState {

  LoadingAddTodoState();
}

class FetchedListsSuccess extends AddTodoState {}

class UpdateAvailableTasks extends AddTodoState {

  UpdateAvailableTasks();
}

class LoadingAddProgressState extends AddTodoState {
  LoadingAddProgressState();
}
