part of 'add_todo_bloc.dart';

@immutable
abstract class AddTodoEvent {}

class AddTodo extends AddTodoEvent {
  final TodoModel model;
  final bool shouldAddNewTask;

  AddTodo(this.model, this.shouldAddNewTask);
}

class FetchDataEvent extends AddTodoEvent {
  FetchDataEvent();
}

class ApplyTodoFilterEvent extends AddTodoEvent {
  final int index;
  final TodoFilterEnum filterType;

  ApplyTodoFilterEvent({required this.index, required this.filterType});
}

class UpdateTodoListEvent extends AddTodoEvent {
  UpdateTodoListEvent();
}
