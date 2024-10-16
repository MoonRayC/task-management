import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lms_project/components/customButton.dart';
import 'package:lms_project/components/customNumInput.dart';
import 'package:lms_project/components/customTextInput.dart';
import 'package:lms_project/pages/task.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> addProduct() async {
    final String url = 'http://119.10.255.198:8000/api/products/';

    Map<String, dynamic> product = {
      'code': _codeController.text,
      'name': _nameController.text,
      'quantity': int.parse(_quantityController.text),
      'price': double.parse(_priceController.text),
      'description': _descriptionController.text,
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(product),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Task()),
        );
      } else {
        throw Exception(
            'Failed to add product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error occurred: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Add Product',
          ),
          backgroundColor: Color(0xFFDCDCDC)),
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
                CustomNumberInput(label: 'Quantity', controller: _quantityController),
                SizedBox(height: 20),
                CustomNumberInput(label: 'Price', controller: _priceController),
                SizedBox(height: 20),
                CustomTextInput(
                    label: 'Description', controller: _descriptionController),
                SizedBox(height: 30),
                CustomButton(
                    width: 200,
                    height: 50,
                    text: 'Add Product',
                    onPressed: addProduct)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
