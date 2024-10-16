import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lms_project/components/customButton.dart';
import 'package:lms_project/components/customTextInput.dart';
import 'package:lms_project/pages/navs.dart';

class InfoFormPage extends StatefulWidget {
  const InfoFormPage({super.key});

  @override
  State<InfoFormPage> createState() => _InfoFormPageState();
}

  class _InfoFormPageState extends State<InfoFormPage> {
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    final _birthdayController = TextEditingController();
    final _mobileNumberController = TextEditingController();
  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthdayController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC1C1C1),
      appBar: AppBar(
        backgroundColor: const Color(0xFFC1C1C1),
        title: Text('Info Form'),
        actions: [
          IconButton(icon: Icon(Icons.help), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/rdc.svg', height: 100),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16.0), 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Almost there...!',
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500, color: Color(0xFF1CFFFF)),
                        ),
                        Text(
                          "Let's add a few details to get started.",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextInput(label: 'First Name', controller: _firstNameController),
                            SizedBox(height: 20),
                            CustomTextInput(label: 'Last Name', controller: _lastNameController),
                            SizedBox(height: 20),
                            CustomTextInput(label: 'Birthday', controller: _birthdayController),
                            SizedBox(height: 20),
                            CustomTextInput(label: 'Mobile Number', controller: _mobileNumberController),
                            SizedBox(height: 20),
                            CustomButton(width: 200, height: 50, text: 'Submit', onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const Navs()));
                            }),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

