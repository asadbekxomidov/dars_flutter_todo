// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:main/service/auth_http_services.dart';
import 'package:main/utils/app_contants.dart';
import 'package:main/views/screens/home_screen.dart';
import 'package:main/views/screens/password_forgotten.dart';
import 'package:main/views/screens/register_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _authHttpServices = AuthHttpServices();
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
          AppLocalizations.of(context)!.login,
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : FilledButton(
                          onPressed: submit,
                          child: const Text("ACCESS"),
                        ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return const RegisterScreen();
                          },
                        ),
                      );
                    },
                    child: const Text("SIGN IN"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return const PasswordForgottenScreen();
                          },
                        ),
                      );
                    },
                    child: const Text(
                      "PASSWORD",
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
