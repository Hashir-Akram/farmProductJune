import 'package:faramproduct/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();

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
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile"),
          backgroundColor: Colors.blue,
          actions: [
            GestureDetector(
              child: const Icon(Icons.notifications_active_outlined),
              onTap: () {},
            )
          ],
        ),
        drawer: appDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 200,
                  width: 200,
                ),
              ),
              Form(
                  key: _formKey,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
                      child: TextFormField(
                        controller: firstNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter first name';
                          }
                          if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
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
                            return 'Please enter first name';
                          }
                          if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'First name should only contain alphabets and spaces';
                          }
                          if (value.length > 15) {
                            return 'First name length should be less than 15';
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
                        onChanged: (value) {
                          setState(() {
                            //You can add any logic here
                          });
                        },
                        validator: (value) {
                          // a function that validates user input and returns an error message if the input is invalid, or null if it is valid.
                          if (value!.isEmpty) {
                            return 'Please enter E-mail address';
                          }
                          if (!RegExp(
                              r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$') //allowing you to perform pattern matching and text manipulation.
                              .hasMatch(value)) {
                            return 'Please enter a valid Email-address';
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
                        controller: dateOfBirthController,
                        onChanged: (value) {
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter date of birth';
                          }
                          return null;
                        },
                        readOnly: true,
                        obscureText: false, //Password would be hidden
                        decoration: InputDecoration(
                            labelText: "D.O.B(YYYY-MM-DD)",
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.calendar_today,
                                color: Colors.green,
                                size: 24,
                              ), onPressed: () {
                                _selectDate(context);
                            },
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
                        controller: firstNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your country';
                          }
                          if (RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                            return 'First name should only contain alphabets and spaces';
                          }
                          if (value.length > 15) {
                            return 'First name length should be less than 15';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Country",
                            prefixIcon: const Icon(
                              Icons.location_city,
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
                    ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const Profile(); //Navigate to a new screen while removing all the previous screens from the navigation stack.
                                  },
                                ), (route) => false);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding:
                            const EdgeInsets.fromLTRB(15, 10, 15, 10)),
                        child: const Text("Submit",
                            style: TextStyle(
                              fontSize: 20,
                            ))),
                  ]))
            ],
          ),
        ),
      ),
    );
  }

 void _selectDate(context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime.now());

    if(picked != null && picked != _selectedDate){
      setState(() {
        _selectedDate = picked;
        // dateOfBirthController.text = _selectedDate.toString();
        dateOfBirthController.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
    }
 }
}
