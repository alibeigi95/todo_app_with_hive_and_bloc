part of 'todos_bloc.dart';

abstract class TodosEvent extends Equatable {
  const TodosEvent();
}

class LoadTodosEvent extends TodosEvent {
  final String username;

  const LoadTodosEvent({required this.username});

  @override
  // TODO: implement props
  List<Object?> get props => [username];
}

class AddTodosEvent extends TodosEvent {
  final String todoText;

  const AddTodosEvent(this.todoText);

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        todoText,
      ];
}

class ToggleTodoEvent extends TodosEvent {
  final String todoTask;

  ToggleTodoEvent(this.todoTask);

  @override
  // TODO: implement props
  List<Object?> get props => [todoTask];


}
