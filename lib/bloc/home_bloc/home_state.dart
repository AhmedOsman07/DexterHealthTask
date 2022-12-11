part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeListFetched extends HomeState {
  final List<QueryDocumentSnapshot<TodoModel>> list;
  final bool shouldAppend;

  HomeListFetched(this.list, this.shouldAppend);
}

class HomeSuccessMessage extends HomeState {
  final String message;

  HomeSuccessMessage(this.message);
}

class RefreshPageState extends HomeState{

  RefreshPageState();

}
