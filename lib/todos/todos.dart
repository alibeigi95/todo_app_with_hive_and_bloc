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
            TodosBloc(RepositoryProvider.of<TodoService>(context))
              ..add(
                LoadTodosEvent(username: username),
              ),
        child: BlocBuilder<TodosBloc, TodosState>(
          builder: (context, state) {
            if (state is TodosLoadedState) {
              return ListView(children: [
                ...state.tasks.map(
                  (e) => ListTile(
                    title: Text(e.task),
                    trailing: Checkbox(
                      value: e.completed,
                      onChanged: (value) {
                        BlocProvider.of<TodosBloc>(context)
                            .add(ToggleTodoEvent(e.task));
                      },
                    ),
                  ),
                ),
                ListTile(
                  title: const Text('create new task'),
                  trailing: const Icon(Icons.add),
                  onTap: () async {
                    final result = await showDialog<String>(
                      context: context,
                      builder: (context) => const Dialog(
                        child: CreateNewTask(),
                      ),
                    );
                    if (result != null) {
                      BlocProvider.of<TodosBloc>(context)
                          .add(AddTodosEvent(result));
                    }
                  },
                )
              ]);
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class CreateNewTask extends StatefulWidget {
  const CreateNewTask({super.key});

  @override
  State<CreateNewTask> createState() => _CreateNewTaskState();
}

class _CreateNewTaskState extends State<CreateNewTask> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('what task what do you want to create?'),
        TextField(
          controller: _inputController,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(_inputController.text);
            },
            child: const Text('save'))
      ],
    );
  }
}
