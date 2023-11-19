
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_with_hive_and_bloc/home/bloc/home_event.dart';
import 'package:todo_app_with_hive_and_bloc/home/bloc/home_state.dart';
import 'package:todo_app_with_hive_and_bloc/services/todo.dart';

import '../../services/authentication.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AuthenticationService _auth;
  final TodoService _todo;

  HomeBloc(this._auth, this._todo) : super(RegisteringServicesState()) {
    on<LoginEvent>((event, emitter) async {
      final user = await _auth.authenticateUser(event.username, event.password);
      if (user != null) {
        emit(SuccessfulLoginState(username: user));
        emit(HomeInitial());
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
