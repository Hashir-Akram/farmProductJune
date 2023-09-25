// ignore_for_file: use_build_context_synchronously

import 'package:faramproduct/services/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:faramproduct/reset_done.dart';

class ResetPassword extends StatefulWidget {
  final String username;
  const ResetPassword({required this.username, Key? key}) : super(key: key);
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifyPasswordController = TextEditingController();
  bool _showPassword = false;
  bool _showVerifyPassword = false;
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
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
                ("Please Enter a New Password"),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
                      child: TextFormField(
                        controller: passwordController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Password';
                          }
                          if (value.length < 8 || value.length > 16) {
                            return 'Password length should be between 8 and 16';
                          }
                          return null;
                        },
                        obscureText: !_showPassword, //Password would be hidden
                        decoration: InputDecoration(
                          labelText: "Password",
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                            size: 24,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
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
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 5, 24, 25),
                      child: TextFormField(
                        controller: verifyPasswordController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the above Password';
                          }
                          if (value != passwordController.text) {
                            return 'Password not matched';
                          }
                          return null;
                        },
                        obscureText:
                            !_showVerifyPassword, //Password would be hidden
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                            size: 24,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showVerifyPassword = !_showVerifyPassword;
                              });
                            },
                            child: Icon(
                              _showVerifyPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
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
                            final username = widget
                                .username; // Replace with your logic to get the username
                            final newPassword = passwordController.text;

                            await dbHelper.updatePassword(
                                username, newPassword);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResetDone(),
                                ),
                                (route) => false);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            alignment: AlignmentDirectional.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: (const Text("Reset Password"))),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
