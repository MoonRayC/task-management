import 'package:flutter/material.dart';
import 'package:lms_project/components/custom_button.dart';
import 'package:lms_project/components/custom_num_input.dart';
import 'package:lms_project/components/custom_text_input.dart';

class AddProject extends StatefulWidget {
  const AddProject({super.key});

  @override
  _AddProjectState createState() => _AddProjectState();
}

class _AddProjectState extends State<AddProject> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void AddProject() {
    print('Product Added: ${_nameController.text}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product "${_nameController.text}" added!')),
    );
    
    _codeController.clear();
    _nameController.clear();
    _quantityController.clear();
    _priceController.clear();
    _descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create new task',
        ),
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
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                SizedBox(height: 50),
                CustomTextInput(label: 'Code', controller: _codeController),
                SizedBox(height: 20),
                CustomTextInput(label: 'Name', controller: _nameController),
                SizedBox(height: 20),
                CustomNumberInput(
                    label: 'Quantity', controller: _quantityController),
                SizedBox(height: 20),
                CustomNumberInput(
                    label: 'Price', controller: _priceController),
                SizedBox(height: 20),
                CustomTextInput(
                    label: 'Description', controller: _descriptionController),
                SizedBox(height: 30),
                CustomButton(
                  width: 200,
                  height: 50,
                  text: 'Add Product',
                  onPressed: AddProject,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
