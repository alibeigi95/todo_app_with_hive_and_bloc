import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:todo_app_with_hive_and_bloc/model/task.dart';
import 'package:todo_app_with_hive_and_bloc/services/todo.dart';

part 'todos_event.dart';

part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final TodoService _todoService;

  TodosBloc(this._todoService) : super(TodosInitial()) {
    on<LoadTodosEvent>((event, emit) {
      final todos = _todoService.getTasks(event.username);
      emit(TodosLoadedState(
        tasks: todos,
        username: event.username,
      ));
    });

    on<AddTodosEvent>((event,emit) async {
      final currentState = state as TodosLoadedState;
      _todoService.addTask(event.todoText, currentState.username);
      add(LoadTodosEvent(username: currentState.username));
    });

    on<ToggleTodoEvent>((event,emit) async {
      final currentState = state as TodosLoadedState;
      _todoService.updateTask(event.todoTask, currentState.username);
      add(LoadTodosEvent(username: currentState.username));
    });
  }
}
