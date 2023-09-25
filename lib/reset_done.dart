import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faramproduct/signIn.dart';

class ResetDone extends StatefulWidget {
  const ResetDone({super.key});

  @override
  State<ResetDone> createState() => _ResetDoneState();
}

class _ResetDoneState extends State<ResetDone> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("My Task Buddy"),
                  content: const Text("Do you want to quit the app?"),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        child: const Text("No")),
                    ElevatedButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlueAccent,
                        ),
                        child: const Text("Yes")),
                  ],
                ));
        return false;
      },
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  child: const Icon(
                    Icons.check_circle_outline,
                    size: 180,
                    color: Colors.lightBlueAccent,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(0),
                  child: const Text(
                    "Reset Done",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w900,
                        color: Colors.lightBlueAccent),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignIn(),
                            ),
                            (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          alignment: AlignmentDirectional.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: (const Text(
                        "Return to SignIn",
                        style: TextStyle(fontSize: 20),
                      ))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
