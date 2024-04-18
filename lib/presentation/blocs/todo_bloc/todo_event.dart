// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class SearchTasksEvent extends TodoEvent {
  final String keywords;

  const SearchTasksEvent(this.keywords);
}

class FetchTasksEvent extends TodoEvent {}

class CreateTasksEvent extends TodoEvent {
  final TodoModel todo;

 const CreateTasksEvent({required this.todo});
}

class UpdateTasksEvent extends TodoEvent {
  final int id;
  final String title;
  final String content;
  const UpdateTasksEvent({
    required this.id,
    required this.title,
    required this.content,
  });
}

class DeleteTasksEvent extends TodoEvent {
  final int id;
  const DeleteTasksEvent(this.id);
}
