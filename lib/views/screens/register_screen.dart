// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:main/service/auth_http_services.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/views/screens/home_screen.dart';
import 'package:main/views/screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  String? email, password, passwordConfirm;
  bool isLoading = false;

  void submit() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      //? Register
      setState(() {
        isLoading = true;
      });
      try {
        await _authHttpServices.register(email!, password!);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) {
              return const HomeScreen();
            },
          ),
        );
      } catch (e) {
        String message = e.toString();
        if (e.toString().contains("EMAIL_EXISTS")) {
          message = "Email there is";
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
        backgroundColor: AppConstants.appBarColor,
        centerTitle: true,
        title: Text(
          "Sign up",
          style: TextStyle(
            fontSize: AppConstants.appBarTextSize,
            color: AppConstants.appBarTextColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextFormField(
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
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter password";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    //? save password
                    password = newValue;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordConfirmController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password confirmation",
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter password confirmation";
                    }
                    if (_passwordController.text !=
                        _passwordConfirmController.text) {
                      return "Passwords are not the same";
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    //? save password confirm
                    passwordConfirm = newValue;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : FilledButton(
                            onPressed: submit,
                            child: const Text("Sign up"),
                          ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) {
                              return const LoginScreen();
                            },
                          ),
                        );
                      },
                      child: const Text("Log in"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
