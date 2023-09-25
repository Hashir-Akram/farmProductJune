// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:faramproduct/services/dbhelper.dart';
import 'package:faramproduct/drawer.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // Controllers for form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late File? selectedImage;
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> userList = [];

  @override
  void initState() {
    super.initState();
    selectedImage = null;
    init();
  }

  // Initialize the selected image and fetch user data
  void init() async {
    String profileLogo = await getDataFromSession('profileLogoPath');
    profileLogo = profileLogo.replaceAll("File: '", "").replaceAll("'", "");
    File path = File(profileLogo);

    setState(() {
      if (profileLogo.isNotEmpty) {
        selectedImage = path;
      } else {
        selectedImage = null;
      }
    });

    fetchData();
  }

  // Fetch user data from the database
  Future<void> fetchData() async {
    List<Map<String, dynamic>> users = await dbHelper.getUsers();
    if (users.isNotEmpty) {
      setState(() {
        userList = users;
        firstNameController.text = users[0]['firstname'];
        lastNameController.text = users[0]['lastname'];
        emailController.text = users[0]['username'];
        passwordController.text = users[0]['password'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Farm Product"),
            content: const Text("Do you want to quit the app?"),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
              ElevatedButton(
                onPressed: () {
                  SystemNavigator.pop();
                },
                child: const Text("Yes"),
              ),
            ],
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile"),
          backgroundColor: Colors.blue,
        ),
        drawer: appDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _pickFromgallery();
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: selectedImage == null
                      ? const Image(
                    image: AssetImage("assets/images/logo.png"),
                    height: 200,
                    width: 200,
                  )
                      : ClipOval(
                    child: Image.file(
                      selectedImage!,
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Form fields
                    buildTextFormField(
                      controller: firstNameController,
                      labelText: "First Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter first name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'First name must contain only alphabets and spaces';
                        }
                        if (value.length > 15) {
                          return 'First name must be less than 15';
                        }
                        return null;
                      },
                      prefixIcon: Icons.person,
                    ),
                    buildTextFormField(
                      controller: lastNameController,
                      labelText: "Last Name",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter last name';
                        }
                        if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                          return 'Last name must contain only alphabets and spaces';
                        }
                        if (value.length > 15) {
                          return 'Last name must be less than 15';
                        }
                        return null;
                      },
                      prefixIcon: Icons.person,
                    ),
                    buildTextFormField(
                      controller: emailController,
                      labelText: "Email",
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
                      prefixIcon: Icons.email_outlined,
                    ),
                    buildTextFormField(
                      controller: passwordController,
                      labelText: "Password",
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter Password';
                        }
                        if (value.length < 8 || value.length > 16) {
                          return 'Password must be between 8 and 16 characters long';
                        }
                        return null;
                      },
                      prefixIcon: Icons.password_outlined,
                      obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await dbHelper.updateUser(
                            firstNameController.text,
                            lastNameController.text,
                            emailController.text,
                            passwordController.text,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Profile updated successfully!'),
                            ),
                          );
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Profile();
                              },
                            ),
                                (route) => false,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                      ),
                      child: const Text(
                        "Update",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a TextFormField with common properties
  Widget buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required FormFieldValidator<String> validator,
    required IconData prefixIcon,
    bool obscureText = false,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.blue,
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
              color: Colors.blue,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }

  // Store data in session using SharedPreferences
  void storeDataInSession(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Retrieve data from session using SharedPreferences
  Future<String> getDataFromSession(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  // Allow the user to pick an image from the gallery
  Future<void> _pickFromgallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path.toString());
      setState(() {
        selectedImage = file;
        storeDataInSession('profileLogoPath', selectedImage.toString());
      });
    } else {
      // User canceled the picker
    }
  }
}
