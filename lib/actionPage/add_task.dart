import 'package:flutter/material.dart';
import 'package:lms_project/components/custom_button.dart';
import 'package:lms_project/components/custom_dropdown_input.dart';
import 'package:lms_project/components/custom_num_input.dart';
import 'package:lms_project/components/custom_text_input.dart';
import 'package:lms_project/components/custom_date_input.dart';
import 'package:lms_project/pages/navs.dart';
import 'package:lms_project/controller/task_controller.dart';
import 'package:lms_project/model/task_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _priorityLevelController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _pointController = TextEditingController();

  final TaskController _taskController = TaskController();

  void addTask() async {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields.')),
      );
      return;
    }

    final newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      startDate: DateTime.tryParse(_startDateController.text) ?? DateTime.now(),
      endDate: DateTime.tryParse(_endDateController.text),
      priorityLevel: _priorityLevelController.text,
      status: _statusController.text,
      points: int.tryParse(_pointController.text) ?? 0,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Save task
    await _taskController.insertTask(newTask);

    // Feedback and navigation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Task "${_titleController.text}" added!')),
    );

    // Clear fields
    _titleController.clear();
    _descriptionController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _priorityLevelController.clear();
    _statusController.clear();
    _pointController.clear();

    // Navigate back to Task page with the task list
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Navs(initialIndex: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new task'),
        backgroundColor: Color(0xFFDCDCDC),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFDCDCDC),
              Color(0xFFC1C1C1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                SizedBox(height: 50),
                CustomTextInput(label: 'Title', controller: _titleController),
                SizedBox(height: 20),
                CustomTextInput(label: 'Description', controller: _descriptionController),
                SizedBox(height: 20),
                CustomDateInput(label: 'Start Date', controller: _startDateController),
                SizedBox(height: 20),
                CustomDateInput(label: 'End Date', controller: _endDateController),
                SizedBox(height: 20),
                CustomDropdownInput(
                  label: 'Priority Level',
                  controller: _priorityLevelController,
                  options: {
                    'low' : 'Low',
                    'medium' : 'Medium',
                    'high' : 'High',
                  },
                ),
                SizedBox(height: 20),
                CustomDropdownInput(
                  label: 'Status',
                  controller: _statusController,
                  options: {
                    'active': 'Active',
                    'onHold': 'On Hold',
                    'completed': 'Completed',
                  },
                ),
                SizedBox(height: 20),
                CustomNumberInput(label: 'Task Point', controller: _pointController),
                SizedBox(height: 30),
                CustomButton(
                  width: 200,
                  height: 50,
                  text: 'Add Task',
                  onPressed: addTask,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
