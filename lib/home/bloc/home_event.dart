import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoginEvent extends HomeEvent {
  final String username;
  final String password;

  const LoginEvent({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}

class RegisterServicesEvent extends HomeEvent {
  @override

  List<Object?> get props => [];

}
