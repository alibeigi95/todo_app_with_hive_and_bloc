import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_hive_and_bloc/services/todo.dart';
import 'package:todo_app_with_hive_and_bloc/todos/bloc/todos_bloc.dart';

class TodosPage extends StatelessWidget {
  final String username;

  const TodosPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: BlocProvider(
        create: (context) =>
            TodosBloc(RepositoryProvider.of<TodoService>(context))..add(
          LoadTodosEvent(username: username),
        ),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(
                children: state.tasks
                    .map(
                      (e) => ListTile(
                        title: Text(e.task),
                        trailing: Checkbox(
                          value: e.completed,
                          onChanged: (value) {},
                        ),
                      ),
                    )
                    .toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
