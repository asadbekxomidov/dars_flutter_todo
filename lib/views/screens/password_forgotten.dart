// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:main/service/auth_http_services.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/views/screens/home_screen.dart';
import 'package:main/views/screens/login_screen.dart';

class PasswordForgottenScreen extends StatefulWidget {
  const PasswordForgottenScreen({super.key});

  @override
  State<PasswordForgottenScreen> createState() =>
      _PasswordForgottenScreenState();
}

class _PasswordForgottenScreenState extends State<PasswordForgottenScreen> {
  final formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
  final emailController = TextEditingController();
  bool isLoading = false;

  String? email;
  String? password;

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      setState(() {
        isLoading = true;
      });
      try {
        await _authHttpServices.login(email!, password!);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return const HomeScreen();
            },
          ),
        );
      } on Exception catch (e) {
        String message = e.toString();
        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email mavjud";
        }
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Error"),
              content: Text(message),
            );
          },
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppConstants.appBarColor,
        title: Text(
          "PASSWORD RECOVERY",
          style: TextStyle(
            fontSize: AppConstants.appBarTextSize,
            color: AppConstants.appBarTextColor,
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Enter email";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  //? save email
                  email = newValue;
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : FilledButton(
                          onPressed: () {
                            _authHttpServices.resetPassword(
                              emailController.text,
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "ACCESS",
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
