part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState {
  final List<TodoModel> todos;

  const TodoLoaded({required this.todos});
}

final class TodoSearched extends TodoState {
  final List<TodoModel> tasks;

  const TodoSearched({required this.tasks});
}

final class TodoDeleted extends TodoState {
  final int id;
  const TodoDeleted(this.id);
}

final class TodoUpdated extends TodoState {
  final int id;
  const TodoUpdated(this.id);
}

final class TodoCreated extends TodoState {
  final int id;
  const TodoCreated(this.id);
}

final class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);
}
