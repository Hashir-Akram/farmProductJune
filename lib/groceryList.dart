import 'package:faramproduct/profile.dart';
import 'package:faramproduct/signIn.dart';
import 'package:faramproduct/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'drawer.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
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
        appBar: AppBar(
          centerTitle: true,
          title: Text("Farm Product"),
          backgroundColor: Colors.blue,
          actions: [
            GestureDetector(child: Icon(Icons.notifications_active_outlined),onTap: (){
              print("Bell Pressed");
            },)
          ],
        ),
        drawer: appDrawer(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("Vegitable", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildProductItem("Broccoli",
                                "assets/images/veg/barocoli.png", 100),
                            _buildProductItem("Bell Pepper",
                                "assets/images/veg/bellpaper.png", 180),
                            _buildProductItem("Cabbage",
                                "assets/images/veg/cabbage.png", 80),
                            _buildProductItem(
                                "Onion", "assets/images/veg/onion.png", 110),
                            _buildProductItem("Tomato",
                                "assets/images/veg/tomato.png", 70),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("Fruits", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildProductItem("Apple",
                                "assets/images/fruits/apple.png", 120),
                            _buildProductItem("Cherry",
                                "assets/images/fruits/cherry.png", 80),
                            _buildProductItem("Dragon",
                                "assets/images/fruits/dragon.png", 50),
                            _buildProductItem("Mango",
                                "assets/images/fruits/mango.png", 200),
                            _buildProductItem("Orange",
                                "assets/images/fruits/orange.png", 60),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20,),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text("Spices", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildProductItem("Cardamom",
                                "assets/images/spices/cardamom.png", 90),
                            _buildProductItem("Clove",
                                "assets/images/spices/clove.png", 180),
                            _buildProductItem("Coriander",
                                "assets/images/spices/coriander.png", 160),
                            _buildProductItem(
                                "Mustard", "assets/images/spices/musted.png", 150),
                            _buildProductItem("Pepper",
                                "assets/images/spices/pepper.png", 90),
                          ],
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

  Widget _buildProductItem(String name, String imagePath, double price){
    return  Container(
      padding:EdgeInsets.all(10) ,
      margin: EdgeInsets.all(5) ,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color:Colors.grey.withOpacity(0.3),
            spreadRadius:2,
            blurRadius: 5,
            offset:Offset(2,2)
          )
        ]

      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 10),
          Image(image: AssetImage(imagePath),width: 120,height: 120,),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "\$ $price",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}