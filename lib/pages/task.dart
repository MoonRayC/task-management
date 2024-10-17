import 'package:flutter/material.dart';
import 'package:lms_project/actionPage/edit_task.dart';

import 'package:lms_project/components/custom_button.dart';
import 'package:lms_project/components/custom_header.dart';
import 'package:lms_project/components/time_history.dart';
import 'package:lms_project/controller/task_controller.dart';
import 'package:lms_project/model/task_model.dart' as model;

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  final TaskController _taskController = TaskController();
  late Future<List<model.Task>> _tasks;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() {
    _tasks = _taskController.getTasks();
  }

  Future<void> _deleteTask(int id) async {
    await _taskController.deleteTask(id);
    _loadTasks();
  }

  void _refreshTasks() {
    setState(() {
      _tasks = _taskController.getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: Column(
          children: [
            Row(
              children: [
                CustomHeader(title: "Tasks List")
              ],
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CustomButton(
                      width: 50, height: 30, text: 'All', onPressed: () {}),
                  SizedBox(width: 8),
                  CustomButton(
                      width: 120,
                      height: 30,
                      text: 'Priority',
                      onPressed: () {}),
                  SizedBox(width: 8),
                  CustomButton(
                      width: 80, height: 30, text: 'Status', onPressed: () {}),
                  SizedBox(width: 8),
                  CustomButton(
                      width: 120, height: 30, text: 'Points', onPressed: () {}),
                ],
              ),
            ),
            SizedBox(height: 20),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.filter_list, size: 30),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<model.Task>>(
                future: _tasks,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading tasks'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No tasks available'));
                  } else {
                    final tasks = snapshot.data!;
                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Dismissible(
                          key: Key(task.id.toString()),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            _deleteTask(task.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${task.title} deleted')),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.all(20),
                            child: Icon(Icons.delete, color: Colors.white),
                          ),
                          child: GestureDetector(
                            onLongPress: () {
                              showDialog(
                                context: context,
                                builder: (context) => EditTaskDialog(
                                  task: task,
                                  taskController: _taskController,
                                  refreshTasks: _refreshTasks,
                                ),
                              ); // Show edit dialog on long press
                            },
                            child: Column(
                              children: [
                                Container(
                                  color: Colors.grey[300],
                                  padding: EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              task.title,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              task.description,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black87,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.access_time,
                                                  size: 16,
                                                  color: TimeHistory(
                                                    createdAt: task.createdAt,
                                                    endDate: task.endDate!,
                                                    status: task.status,
                                                  ).getTextColor(),
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  TimeHistory(
                                                    createdAt: task.createdAt,
                                                    endDate: task.endDate!,
                                                    status: task.status,
                                                  ).getTimeAgo(),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: TimeHistory(
                                                      createdAt: task.createdAt,
                                                      endDate: task.endDate!,
                                                      status: task.status,
                                                    ).getTextColor(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      CircleAvatar(
                                        radius: 16,
                                        backgroundColor: Colors.blueAccent,
                                        child: Text(
                                          task.points.toString(),
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}