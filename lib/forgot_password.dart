// ignore_for_file: use_build_context_synchronously

import 'package:faramproduct/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:faramproduct/services/dbhelper.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  final DatabaseHelper dbHelper =
      DatabaseHelper.instance; // Initialize your database helper

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const Image(
                image: AssetImage("assets/images/forgotPassword.jpg"),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: const Text(
                ("Enter Your E-mail ID"),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 10),
                      child: TextFormField(
                        controller: emailController,
                        onChanged: (value) {
                          setState(() {
                            // You can add logic here if needed
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Email Address';
                          }
                          if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid Email address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: Colors.green,
                            size: 24,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.grey,
                              width: 1.5, // Adjust the border width
                            ),
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the border radius
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 1.5, // Adjust the border width
                            ),
                            borderRadius: BorderRadius.circular(
                                8.0), // Adjust the border radius
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final email = emailController.text;
                            final emailExists =
                                await dbHelper.doesEmailExist(email);
                            if (emailExists) {
                              // Email exists in the database, navigate to reset password screen
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ResetPassword(username: email),
                                ),
                              );
                            } else {
                              // Email does not exist, show an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Email does not exist in the database'),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            alignment: AlignmentDirectional.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: (const Text("Forgot Password"))),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
