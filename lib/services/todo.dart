import 'package:hive/hive.dart';
import 'package:todo_app_with_hive_and_bloc/model/task.dart';

class TodoService {
  late Box<Task> _tasks;

  Future<void> init() async {
    Hive.registerAdapter(TaskAdapter());
    _tasks = await Hive.openBox('tasks');

     await _tasks.clear();
   await _tasks.add(Task(user: 'ali', task: 'this is a test', completed: true));
   await _tasks.add(Task(user: 'ali2', task: 'this is a test2', completed: false));
  }

  List<Task> getTasks(final String username) {
    final tasks = _tasks.values.where((e) => e.user == username);
    return tasks.toList();
  }

  void addTask(final String task, final String username) {
    _tasks.add(Task(user: username, task: task, completed: false));
  }

  Future<void> removeTask(final String task, final String username) async {
    final taskToRemove =
        _tasks.values.firstWhere((e) => e.task == task && e.user == username);
    await taskToRemove.delete();
  }

  Future<void> updateTask(final String task, final String username,
      {final bool? completed}) async {
    final taskToEdit =
        _tasks.values.firstWhere((e) => e.user == username && e.task == task);
    final index = taskToEdit.key as int;
    await _tasks.put(
        index,
        Task(
          user: username,
          task: task,
          completed: completed ?? taskToEdit.completed,
        ));
  }
}
