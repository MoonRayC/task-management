import 'package:flutter/material.dart';
import 'package:lms_project/components/custom_date_input.dart';
import 'package:lms_project/components/custom_dropdown_input.dart';
import 'package:lms_project/components/custom_num_input.dart';
import 'package:lms_project/components/custom_text_input.dart';
import 'package:lms_project/model/task_model.dart' as model;
import 'package:lms_project/controller/task_controller.dart';

class EditTaskDialog extends StatelessWidget {
  final model.Task task;
  final TaskController taskController;
  final Function() refreshTasks;

  const EditTaskDialog({
    super.key,
    required this.task,
    required this.taskController,
    required this.refreshTasks,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController =
        TextEditingController(text: task.title);
    final TextEditingController descriptionController =
        TextEditingController(text: task.description);
    final TextEditingController startDateController =
        TextEditingController(text: task.startDate.toString());
    final TextEditingController endDateController =
        TextEditingController(text: task.endDate.toString());
    final TextEditingController priorityLevelController =
        TextEditingController(text: task.priorityLevel);
    final TextEditingController statusController =
        TextEditingController(text: task.status);
    final TextEditingController pointsController =
        TextEditingController(text: task.points.toString());

    return AlertDialog(
      title: Text('Edit Task'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomTextInput(label: 'Title', controller: titleController),
          SizedBox(height: 20),
          CustomTextInput(
              label: 'Description', controller: descriptionController),
          SizedBox(height: 20),
          CustomDateInput(label: 'Start Date', controller: startDateController),
          SizedBox(height: 20),
          CustomDateInput(label: 'End Date', controller: endDateController),
          SizedBox(height: 20),
          CustomDropdownInput(
              label: 'Priority Level',
              controller: priorityLevelController,
              options: {
                'low': 'Low',
                'medium': 'Medium',
                'high': 'High',
              }),
          SizedBox(height: 20),
          CustomDropdownInput(
            label: 'Status',
            controller: statusController,
            options: {
              'active': 'Active',
              'onHold': 'On Hold',
              'completed': 'Completed',
            },
          ),
          SizedBox(height: 20),
          CustomNumberInput(label: 'Points', controller: pointsController),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final updatedTask = model.Task(
              id: task.id,
              title: titleController.text,
              description: descriptionController.text,
              startDate: task.startDate,
              endDate: task.endDate,
              createdAt: task.createdAt,
              updatedAt: DateTime.now(),
              priorityLevel: task.priorityLevel,
              status: task.status,
              points: task.points,
            );
            taskController.updateTask(updatedTask).then((_) {
              refreshTasks();
              Navigator.of(context).pop();
            });
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
