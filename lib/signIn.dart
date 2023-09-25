// ignore_for_file: use_build_context_synchronously

import 'package:faramproduct/groceryList.dart';
import 'package:faramproduct/services/dbhelper.dart';
import 'package:faramproduct/signUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'forgot_password.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Farm Product"),
              content: const Text("Do You want to quit the app?"),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("No")),
                ElevatedButton(
                    onPressed: () {
                      SystemNavigator.pop();
                    },
                    child: const Text("Yes")),
              ],
            ));
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                child: const Image(
                  image: AssetImage("assets/images/splash1.png"),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(2),
                child: const Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),
              const Text("Welcome to Farm Product",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              const Text(
                "Login",
                style: TextStyle(
                    color: Colors.black38,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 5, 24, 10),
                        child: TextFormField(
                          controller: passwordController,
                          onChanged: (value) {
                            setState(() {
                              // You can add logic here if needed
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter Password';
                            }
                            if (value.length < 8 || value.length > 16) {
                              return 'Password length should be between 8 & 16';
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: const Icon(
                              Icons.password_outlined,
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
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 24, 10),
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignIn(),
                              ),
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const ForgotPassword()),
                              );
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _handleSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        ),
                        child: const Text("Login",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                      const Text(
                        "OR",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SignUp();
                                },
                              ), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        ),
                        child: const Text("Sign Up",
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences
          .getInstance(); // Get an instance of SharedPreferences
      prefs.setBool('isSignedIn',
          true); // Set a boolean value in SharedPreferences to indicate user is signed in
      _signIn(context);
    }
  }

  void _signIn(BuildContext context) async {
    final username = emailController.text.trim();
    final password = passwordController.text.trim();

    final db = await DatabaseHelper.instance.database;
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );

    if (result.isNotEmpty) {
      // Authentication successful, navigate to the next page
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const GroceryList()),
            (route) => false,
      );
    } else {
      // Authentication failed, show an error message

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Authentication failed. Check your credentials.'),
        ),
      );
    }
    if (!result.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isSignedIn', false);
    }
  }
}
