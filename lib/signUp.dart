import 'package:faramproduct/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'groceryList.dart';


class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController(); // Manages the text input of form text fields, allowing changes in the text input.
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope( //used to control what happens when the user presses the back button by intercepting/blocking the back button press
        onWillPop: // enables you to control the behavior of the back button and perform specific actions, such as showing a dialog box
    () async { //asynchronous functions, allowing non-blocking operations and the use of await to pause execution and wait for asynchronous results.
      showDialog(context: context, builder: (context) => AlertDialog( //Context told us from which part it belongs to
        title: Text("Farm Product"),
        content: Text("Do you want to exit the app?"),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        actions: [ // user interactions that trigger specific events or behaviors within the app, implemented using appropriate widgets and event handlers.
          ElevatedButton(onPressed: (){
            Navigator.pop(context);//used to pop a route off the navigation stack within your Flutter application.
          }, child: Text("No")),
          ElevatedButton(onPressed: (){
            SystemNavigator.pop();//used to pop the entire flutter application and return to the device's home screen.
          }, child: Text("Yes"))
        ],
      ));
      return false;
    },
    child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image(
                image: AssetImage("assets/images/splash1.png"),
                height: 80,
              ),
            ),
            Container(
              child: Image(
                image: AssetImage("assets/images/logo.png"),
                height: 250,
              ),
            ),
            const Text("Welcome To Farm Product",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("SignUp",
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
                      padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
                      child: TextFormField(
                        controller: firstNameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter first name';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)){
                            return 'First name should only contain alphabets and spaces';
                          }
                          if(value.length > 15){
                            return 'First name length should be less than 15';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "First Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.green,
                              size: 24,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            )
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
                      child: TextFormField(
                        controller: lastNameController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter last name';
                          }
                          if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)){
                            return 'Last name should only contain alphabets and spaces';
                          }
                          if(value.length > 15){
                            return 'Last name length should be less than 15';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Last Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.green,
                              size: 24,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            )
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
                      child: TextFormField(
                        controller: emailController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter email address';
                          }
                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$').hasMatch(value)){
                            return 'Please enter a valid E-mail address';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Email",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.green,
                              size: 24,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            )
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(24, 5, 24, 10),
                      child: TextFormField(
                        controller: passwordController,
                        onChanged: (value){
                          setState(() {

                          });
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Please enter a Password';
                          }
                          if(value.length < 8 || value.length > 16){
                            return 'Password length should be between 8 and 16';
                          }
                          return null;
                        },
                        obscureText: true,//Password would be hidden
                        decoration: InputDecoration(
                            labelText: "Password",
                            prefixIcon: Icon(
                              Icons.password_outlined,
                              color: Colors.green,
                              size: 24,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.green,
                                  width: 1.5
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            )
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 5, 24, 10),
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ),
                          );
                        },
                        child: Text(
                          'Already a member? LogIn',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    ElevatedButton(onPressed: (){
                      if(_formKey.currentState!.validate()){
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) {
                            return GroceryList();//Navigate to a new screen while removing all the previous screens from the navigation stack.
                          },
                        ), (route) => false);
                      }
                    }, child: Text("SignUp", style: TextStyle(
                      fontSize: 20,
                    )
                    ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10)
                        )
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    )
    );
  }
}
