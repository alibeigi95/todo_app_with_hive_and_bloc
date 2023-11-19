import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_hive_and_bloc/home/bloc/home_bloc.dart';
import 'package:todo_app_with_hive_and_bloc/home/bloc/home_event.dart';
import 'package:todo_app_with_hive_and_bloc/home/bloc/home_state.dart';
import 'package:todo_app_with_hive_and_bloc/services/authentication.dart';
import 'package:todo_app_with_hive_and_bloc/services/todo.dart';
import 'package:todo_app_with_hive_and_bloc/todos/todos.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final userNameTextController = TextEditingController();
  final passWordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('login to todo app')),
        body: BlocProvider(
          create: (context) => HomeBloc(
            RepositoryProvider.of<AuthenticationService>(context),
            RepositoryProvider.of<TodoService>(context),
          )..add(RegisterServicesEvent()),
          child: BlocConsumer<HomeBloc, HomeState>(
            listener: (context, state) {
              if (state is SuccessfulLoginState) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TodosPage(username: state.username),
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is HomeInitial) {
                return Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'username'),
                      controller: userNameTextController,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'password'),
                      controller: passWordTextController,
                    ),
                    ElevatedButton(
                      onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                        LoginEvent(
                          username: userNameTextController.text,
                          password: passWordTextController.text,
                        ),
                      ),
                      child: const Text('Login'),
                    )
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      );
}
