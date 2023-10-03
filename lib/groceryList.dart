import 'package:faramproduct/cart.dart';
import 'package:faramproduct/productPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../services/dbhelper.dart';
import 'drawer.dart';
import '../model/userTable.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({Key? key}) : super(key: key);

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  bool isFiltering = false;
  String? selectedCategory;
  List<Widget> filteredItems = [];

  // Define categories and their corresponding product lists
  late final Map<String, List<Widget>> categories;

  @override
  void initState() {
    super.initState();

    categories = {
      "Vegetable": [
        _buildProductItem("Broccoli", "assets/images/veg/barocoli.png", 100),
        _buildProductItem("Bell Pepper", "assets/images/veg/bellpaper.png", 180),
        _buildProductItem("Cabbage", "assets/images/veg/cabbage.png", 80),
        _buildProductItem("Onion", "assets/images/veg/onion.png", 110),
        _buildProductItem("Tomato", "assets/images/veg/tomato.png", 70),
      ],
      "Fruits": [
        _buildProductItem("Apple", "assets/images/fruits/apple.png", 120),
        _buildProductItem("Cherry", "assets/images/fruits/cherry.png", 80),
        _buildProductItem("Dragon", "assets/images/fruits/dragon.png", 50),
        _buildProductItem("Mango", "assets/images/fruits/mango.png", 200),
        _buildProductItem("Orange", "assets/images/fruits/orange.png", 60),
      ],
      "Spices": [
        _buildProductItem("Cardamom", "assets/images/spices/cardamom.png", 90),
        _buildProductItem("Clove", "assets/images/spices/clove.png", 180),
        _buildProductItem("Coriander", "assets/images/spices/coriander.png", 160),
        _buildProductItem("Mustard", "assets/images/spices/musted.png", 150),
        _buildProductItem("Pepper", "assets/images/spices/pepper.png", 90),
      ],
      "Dairy Products": [
        _buildProductItem("Butter", "assets/images/dairy/butter.webp", 190),
        _buildProductItem("Cheese", "assets/images/dairy/cheese.webp", 80),
        _buildProductItem("Cream", "assets/images/dairy/cream.jpg", 120),
        _buildProductItem("Milk", "assets/images/dairy/milk.webp", 60),
        _buildProductItem("Yogurt", "assets/images/dairy/yogurt.webp", 80),
      ],
      "Flowers": [
        _buildProductItem("Daisy", "assets/images/flowers/daisy.jpg", 90),
        _buildProductItem("Elder Flower", "assets/images/flowers/elderflower.jpg", 60),
        _buildProductItem("Hibiscus", "assets/images/flowers/hibiscus.jpg", 100),
        _buildProductItem("Lavender", "assets/images/flowers/lavender.jpg", 50),
        _buildProductItem("Rose", "assets/images/flowers/rose.jpg", 150),
      ],
      "Grains": [
        _buildProductItem("Corn", "assets/images/grains/corn.jpeg", 90),
        _buildProductItem("Millet", "assets/images/grains/millet.jpg", 180),
        _buildProductItem("Oats", "assets/images/grains/oats.webp", 160),
        _buildProductItem("Rice", "assets/images/grains/rice.jpg", 150),
        _buildProductItem("Wheat Flour", "assets/images/grains/wheat_flour.jpg", 90),
      ],
      "Pulses": [
        _buildProductItem("Black Beans", "assets/images/pulses/black_beans.webp", 90),
        _buildProductItem("Chickpea", "assets/images/pulses/chickpea.jpg", 180),
        _buildProductItem("Kidney Beans", "assets/images/pulses/kidney_beans.webp", 160),
        _buildProductItem("Lentils", "assets/images/pulses/lentils.webp", 150),
        _buildProductItem("Moong Beans", "assets/images/pulses/moong_beans.jpg", 90),
      ],
    };
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
            title: const Text("Farm Product"),
            backgroundColor: Colors.blue,
            actions: [
              IconButton(
                onPressed: () {
                  _showFilterDialog();
                },
                icon: const Icon(Icons.filter_list_alt),
              ),
            ],
          ),
          drawer: appDrawer(context),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (isFiltering)
                  _buildFilteredCategories()
                else
                  _buildAllCategories(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                      (route) => false);
            },
            child:
            const Icon(Icons.shopping_cart_outlined, color: Colors.white),
          )),
    );
  }

  Widget _buildAllCategories() {
    List<Widget> categoryWidgets = [];
    categories.forEach((category, products) {
      categoryWidgets.add(_buildProductCategory(category, products));
    });
    return Column(
      children: categoryWidgets,
    );
  }

  Widget _buildFilteredCategories() {
    if (selectedCategory != null) {
      final products = categories[selectedCategory!];
      if (products != null) {
        return _buildProductCategory(selectedCategory!, products);
      }
    }
    return const SizedBox.shrink();
  }

  Widget _buildProductCategory(String categoryName, List<Widget> products) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(0),
            child: Text(
              categoryName,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: products,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(String name, String imagePath, double price) {
    final item = Item(
      name: name,
      imagePath: imagePath,
      price: price,
    );

    return GestureDetector(
      onTap: () {
        _addItemToDatabase(item);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPreview(item: item),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              name,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 10),
            Image(
              image: AssetImage(imagePath),
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "\$ $price",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addItemToDatabase(Item item) async {
    final dbHelper = DatabaseHelper.instance;
    await dbHelper.productAdd(item.name, item.imagePath, item.price);
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Filter Categories"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final category in categories.keys)
                ListTile(
                  title: Text(category),
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                      isFiltering = true;
                    });
                    Navigator.pop(context);
                  },
                ),
              ListTile(
                title: const Text("Show All"),
                onTap: () {
                  setState(() {
                    selectedCategory = null;
                    isFiltering = false;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
