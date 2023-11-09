import 'package:flutter/material.dart';
import 'repository.dart';
import 'viewmodel.dart';

import '../mvvm/observer.dart';
import 'model.dart';

class TaskWidget extends StatefulWidget {
  const TaskWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TaskWidgetState();
  }
}

class _TaskWidgetState extends State<TaskWidget> implements EventObserver {
// Consider making TaskRepository() a singleton by using a factory
  final TaskViewModel _viewModel = TaskViewModel(TaskRepository());
  bool _isLoading = false;
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _viewModel.subscribe(this);
  }

  @override
  void dispose() {
    super.dispose();
    _viewModel.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TaskApp 2000"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _viewModel.loadTasks();
          },
          child: const Icon(Icons.refresh),
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_tasks[index].title),
              subtitle: Text(_tasks[index].description),
            );
          },
        )
    );
  }

  @override
  void notify(ViewEvent event) {
    if (event is LoadingEvent) {
      setState(() {
        _isLoading = event.isLoading;
      });
    } else if (event is TasksLoadedEvent) {
      setState(() {
        _tasks = event.tasks;
      });
    }
  }
}