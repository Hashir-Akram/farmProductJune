// ignore_for_file: use_build_context_synchronously

import 'package:faramproduct/services/dbhelper.dart';
import 'package:faramproduct/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'groceryList.dart';
import '../model/userTable.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
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
                content: const Text("Do you want to exit the app?"),
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
                      child: const Text("Yes"))
                ],
              ));
          return false;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(3),
                  child: const Image(
                    image: AssetImage("assets/images/splash1.png"),
                    height: 80,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(3),
                  child: const Image(
                    image: AssetImage("assets/images/logo.png"),
                    height: 250,
                  ),
                ),
                const Text(
                  "Welcome To Farm Product",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "SignUp",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                          child: TextFormField(
                            controller: firstNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter first name';
                              }
                              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                return 'First name should only contain alphabets and spaces';
                              }
                              if (value.length > 15) {
                                return 'First name length should be less than 15';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "First Name",
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.green,
                                  size: 24,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 1.5),
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                          child: TextFormField(
                            controller: lastNameController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter last name';
                              }
                              if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                                return 'Last name should only contain alphabets and spaces';
                              }
                              if (value.length > 15) {
                                return 'Last name length should be less than 15';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Last Name",
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: Colors.green,
                                  size: 24,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 1.5),
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                          child: TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email address';
                              }
                              if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,}$')
                                  .hasMatch(value)) {
                                return 'Please enter a valid E-mail address';
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
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 1.5),
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
                          ),
                        ),
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
                            obscureText: true, //Password would be hidden
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
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 1.5),
                                  borderRadius: BorderRadius.circular(8.0),
                                )),
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
                            child: const Text(
                              'Already a member? LogIn',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _signUp(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                padding:
                                const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                            child: const Text("SignUp",
                                style: TextStyle(
                                  fontSize: 20,
                                ))),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }

  void _signUp(BuildContext context) async {
    final username = emailController.text.trim();
    final password = passwordController.text.trim();
    final firstname = firstNameController.text.trim();
    final lastname = lastNameController.text.trim();

    final db = await DatabaseHelper.instance.database;

    // Check if the username is already taken
    final existingUsers = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (existingUsers.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('E-mail is already taken. Please choose another one.'),
        ),
      );
    } else {
      // Register the user
      final user = User(
          username: username,
          password: password,
          firstname: firstname,
          lastname: lastname);
      await db.insert('users', user.toMap());

      // Registration successful, navigate to the sign-in page
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
        builder: (context) {
          return const GroceryList();
        },
      ), (route) => false);
    }
  }
}
