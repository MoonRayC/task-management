import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lms_project/components/custom_button.dart';
import 'package:lms_project/components/custom_text_input.dart';
import 'package:lms_project/pages/info_form.dart';
import 'package:lms_project/pages/navs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoginActive = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFC1C1C1),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/rdc.svg', height: 100),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          TextButton(
                            onPressed: () =>
                                setState(() => isLoginActive = true),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: isLoginActive
                                    ? const Color(0xFF1CFFFF)
                                    : Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (isLoginActive)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                width: 150,
                                height: 5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF1CFFFF),
                                      Color(0xFF0A0448)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 20),
                      Column(
                        children: [
                          TextButton(
                            onPressed: () =>
                                setState(() => isLoginActive = false),
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                color: !isLoginActive
                                    ? const Color(0xFF1CFFFF)
                                    : Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (!isLoginActive)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                width: 150,
                                height: 5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF1CFFFF),
                                      Color(0xFF0A0448)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  if (isLoginActive) ...[
                    CustomTextInput(
                        label: "Username",
                        controller: _usernameController,
                        icon: Icons.person),
                    SizedBox(height: 20),
                    CustomTextInput(
                        label: "Password",
                        controller: _passwordController,
                        obscureText: true,
                        icon: Icons.lock),
                  ] else ...[
                    CustomTextInput(
                        label: "Username",
                        controller: _usernameController,
                        icon: Icons.person),
                    SizedBox(height: 20),
                    CustomTextInput(
                        label: "Email",
                        controller: _emailController,
                        icon: Icons.email),
                    SizedBox(height: 20),
                    CustomTextInput(
                        label: "Password",
                        controller: _passwordController,
                        obscureText: true,
                        icon: Icons.lock),
                    SizedBox(height: 20),
                    CustomTextInput(
                        label: "Confirm Password",
                        controller: TextEditingController(),
                        obscureText: true,
                        icon: Icons.lock),
                  ],
                  SizedBox(height: 20),
                  CustomButton(
                    width: 200,
                    height: 50,
                    text: isLoginActive ? "Login" : "Signup",
                    onPressed: () {
                      print(isLoginActive
                          ? "login button is pressed"
                          : "signup button is pressed");
                      if (isLoginActive) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Navs()));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => InfoFormPage()));
                      }
                    },
                  ),
                  if (isLoginActive)
                    Column(
                      children: [
                        SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: const Color(0xFF0A0448)),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 20),
                  _buildSocialButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: SizedBox(
            height: 40,
            width: 40,
            child: SvgPicture.asset('assets/images/fb_icon.svg'),
          ),
          onPressed: () {
            print("Facebook button is pressed");
          },
        ),
        IconButton(
          icon: SizedBox(
            height: 40,
            width: 40,
            child: SvgPicture.asset('assets/images/google_icon.svg'),
          ),
          onPressed: () {
            print("Google button is pressed");
          },
        ),
        IconButton(
          icon: SizedBox(
            height: 40,
            width: 40,
            child: SvgPicture.asset('assets/images/x_icon.svg'),
          ),
          onPressed: () {
            print("X button is pressed");
          },
        ),
      ],
    );
  }
}
