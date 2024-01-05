import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_hive_and_bloc/home/bloc/home_event.dart';
import 'package:todo_app_with_hive_and_bloc/home/bloc/home_state.dart';
import 'package:todo_app_with_hive_and_bloc/services/todo.dart';

import '../../services/authentication.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(RegisteringServicesState()) {
    on<LoginEvent>((event, emit) async {
      final user = await _auth.authenticateUser(event.username, event.password);
      if (user != null) {
        emit(SuccessfulLoginState(username: user));
        emit(const HomeInitial());
      }
    });

    on<RegisterAccountEvent>((event, emit) async {
      final result = await _auth.createUser(event.username, event.password);
      switch (result) {
        case UserCreationResult.success:
          emit(SuccessfulLoginState(username: event.username));
          break;
        case UserCreationResult.failure:
          emit(const HomeInitial(error: 'theres been error'));
          break;
        case UserCreationResult.alreadyExists:
          emit(const HomeInitial(error: 'theres already exists'));
          break;
      }
    });

    on<RegisterServicesEvent>(
      (event, emit) async {
        await _auth.init();
        await _todo.init();
        emit(const HomeInitial());
      },
    );
  }
}
