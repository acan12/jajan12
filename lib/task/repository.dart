import 'model.dart';

class TaskRepository {
  final List<Task> _taskList = [
    Task(
      0,
      "Study MVVM",
      "In Order to avoid ugly state management libraries and collect continously technical debt, i should study proper state management patterns",
      false),
  ];

  void addTask(Task task) {
    task.id = _taskList.length;
    _taskList.add(task);
  }

  void removeTask(Task task) {
    _taskList.remove(task);
  }

  void updateTask(Task task) {
    _taskList[_taskList.indexWhere((element) => element.id == task.id)] = task;
  }

  Future<List<Task>> loadTasks() async {
    await Future.delayed(const Duration(seconds: 2));
    return Future.value(_taskList);
  }
}