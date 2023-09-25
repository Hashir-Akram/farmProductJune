import 'package:faramproduct/drawer.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("About"),
        backgroundColor: Colors.blue,
      ),
      drawer: appDrawer(context),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10),
                child: const Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 250,
                ),
              ),
              Container(
                alignment: AlignmentDirectional.topStart,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: const Text(
                  "About Farm Product: Connecting You to Fresh Farm Goods: ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.justify,
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: const Text(
                    "Discover the essence of the countryside with our Farm Product app. "
                    "Explore and purchase a curated selection of farm-fresh goods, straight from local growers. "
                    "Join us in supporting local agriculture and savor the authentic flavors of nature.",
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.justify),
              ),
              Container(
                alignment: AlignmentDirectional.centerEnd,
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                child: const Text("Developed in 2023",
                    style:
                        TextStyle(letterSpacing: 0.3)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                alignment: AlignmentDirectional.centerEnd,
                child: const Text(
                  "- for June Batch",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
