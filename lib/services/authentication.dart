import 'package:hive/hive.dart';
import 'package:todo_app_with_hive_and_bloc/model/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox('usersBox');

    await _users.clear();
    await _users.add(User(username: 'ali', password: '123456'));
    await _users.add(User(username: 'ghb', password: '654321'));
  }

  Future<String?> authenticateUser(
      final String username, final String password) async {
    final success = await _users.values
        .any((e) => e.username == username && e.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }
}
