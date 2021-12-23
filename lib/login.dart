import 'package:flutter/material.dart';
import 'package:test_file_pick/widgets/custom_button.dart';
import 'package:test_file_pick/widgets/custom_text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test File Pick"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomTextField(
            emailController,
            "Email",
            "Enter you Email",
            false,
            (value) {
              Pattern pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regex = RegExp(pattern as String);
              return (!regex.hasMatch(value!))
                  ? "Please Enter Valid Email"
                  : null;
            },
          ),
          CustomTextField(
            passwordController,
            "Password",
            "Enter your Password",
            true,
            (value) {
              return !value.isEmpty ? "Password cannot be empty" : null;
            },
          ),
          const SizedBox(
            height: 8.0,
          ),
          CustomButton("Login", login),
          const SizedBox(
            height: 8.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: [
              const Text("Don't have a account? "),
              GestureDetector(
                onTap: createAccount,
                child: const Text(
                  "Create Account",
                  style: TextStyle(color: Colors.blueAccent),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void createAccount() {}

  void login() {}
}
