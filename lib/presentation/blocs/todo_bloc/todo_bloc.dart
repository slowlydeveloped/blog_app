import 'package:bloc/bloc.dart';
import 'package:blog_app/data/data_sources/remote/my_sqlite.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/todo_model.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final DataBaseHelper _dataBaseHelper;

  TodoBloc({required DataBaseHelper dataBaseHelper})
      : _dataBaseHelper = dataBaseHelper,
        super(TodoInitial()) {
        
    // Showing all the tasks
    on<FetchTasksEvent>((event, emit) async {
      emit(TodoLoading());
      try {
        final todos = await _dataBaseHelper.getTasks();
        print('Fetched todos: $todos');
        emit(TodoLoaded(todos: todos));
      } catch (e) {
        emit(const TodoError("Failed to load"));
        print('Error fetching todos: $e');
      }
    });

    //Searching the Tasks
    on<SearchTasksEvent>((event, emit) async {
       emit(TodoLoading());
      try {
        final todos = await _dataBaseHelper.searchTasks(event.keywords);
        print("doing with ${todos}");
        emit(TodoSearched(tasks: todos));
      } catch (e) {
        emit(const TodoError("Failed to Search"));
      }
    });

    //Updating the tasks
    on<UpdateTasksEvent>((event, emit) async {
       emit(TodoLoading());
      try {
        final id = await _dataBaseHelper.updateTasks(
            event.title, event.content, event.id);
        final todos = await _dataBaseHelper.getTasks();
        emit(TodoUpdated(id));
        print("Updated $id");
        emit(TodoLoaded(todos: todos));
        print("Updated $todos");
      } catch (e) {
        emit(const TodoError("Failed to Update"));
      }
    });

    //Deleting the Tasks
    on<DeleteTasksEvent>((event, emit) async {
       emit(TodoLoading());
      try {
        await _dataBaseHelper.deleteTasks(event.id);
        final todos = await _dataBaseHelper.getTasks();
        emit(TodoDeleted(event.id));
        emit(TodoLoaded(todos: todos));
      } catch (e) {
        emit(const TodoError("Failed to Delete"));
      }
    });

    // Creating a new task
    on<CreateTasksEvent>((event, emit) async {
       emit(TodoLoading());
      try {
        final id = await _dataBaseHelper.createTasks(event.todo);
        print('Createded todos: $id');
        final todos = await _dataBaseHelper.getTasks();
        emit(TodoCreated(id));
        emit(TodoLoaded(todos: todos));
      } catch (e) {
        emit(const TodoError("Failed to Create"));
      }
    });
  }
}
