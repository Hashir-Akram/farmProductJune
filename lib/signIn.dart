import 'package:faramproduct/groceryList.dart';
import 'package:faramproduct/signUp.dart';
import 'package:faramproduct/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      onWillPop: () async{
        showDialog(context: context, builder: (context) => AlertDialog(
          title: Text("Farm Product"),
          content: Text("Do You want to quit the app?"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: [
            ElevatedButton(onPressed: (){
             Navigator.pop(context);
            }, child: Text("No")),
        ElevatedButton(onPressed: (){
          SystemNavigator.pop();
        }, child: Text("Yes")),
          ],
        ) );
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Image(
                  image: AssetImage("assets/images/splash1.png"),
                ),
              ),

              Container(
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                ),
              ),

              const Text("Welcome to Farm Product",style: TextStyle(
                color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,
              )),
              const Text("Login",style: TextStyle(
              color: Colors.black38,fontSize: 25,fontWeight: FontWeight.bold),),


              Form(
                  key: _formKey,
                  child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 24, 24, 10),
                    child: TextFormField(
                      controller: emailController,
                      onChanged: (value) {
                        setState(() {
                          // You can add logic here if needed
                        });
                      },
                      validator: (value){
                        if (value!.isEmpty) {
                          return 'Please enter Email Address';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Please enter a valid Email address';
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
                            width: 1.5, // Adjust the border width
                          ),
                          borderRadius: BorderRadius.circular(8.0), // Adjust the border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5, // Adjust the border width
                          ),
                          borderRadius: BorderRadius.circular(8.0), // Adjust the border radius
                        ),

                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(24, 5, 24, 10),
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
                        if(value.length < 8 || value.length > 16){
                          return 'Password length should be between 8 & 16';
                        }
                        return null;
                      },
                      obscureText: true,
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
                            width: 1.5, // Adjust the border width
                          ),
                          borderRadius: BorderRadius.circular(8.0), // Adjust the border radius
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.green,
                            width: 1.5, // Adjust the border width
                          ),
                          borderRadius: BorderRadius.circular(8.0), // Adjust the border radius
                        ),

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
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: (){

                    if(_formKey.currentState!.validate()){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return GroceryList();
                        },
                      ), (route) => false);
                    }
                  }, child: Text("Login",style: TextStyle(
                    fontSize: 20,
                  )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    ),
                  ),
                  const Text("OR",style: TextStyle(
                      color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),

                  ElevatedButton(onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return SignUp();
                      },
                    ), (route) => false);
                  },
                    child: Text("Sign Up",style: TextStyle(
                    fontSize: 20,
                  )),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}