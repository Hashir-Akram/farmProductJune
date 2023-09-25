// ignore_for_file: use_build_context_synchronously

import 'package:faramproduct/groceryList.dart';
import 'package:flutter/material.dart';
import 'package:faramproduct/drawer.dart';
import 'package:faramproduct/services/dbhelper.dart';
import '../model/userTable.dart';
import 'cart.dart';

class ProductPreview extends StatefulWidget {
  final Item item;

  const ProductPreview({required this.item, Key? key}) : super(key: key);

  ProductPreview.fromFavorite({required FavoriteItem favoriteItem, Key? key})
      : item = Item(
    name: favoriteItem.name,
    imagePath: favoriteItem.imagePath,
    price: favoriteItem.price,
  ),
        super(key: key);

  @override
  ProductPreviewState createState() => ProductPreviewState();
}

class ProductPreviewState extends State<ProductPreview> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  bool isInFavorites = false;
  int quantity = 1;

  double get totalAmount => widget.item.price * quantity;

  @override
  void initState() {
    super.initState();
    checkIfInFavorites();
  }

  // Check if the item is in favorites when the widget initializes
  void checkIfInFavorites() async {
    final isFavorite = await dbHelper.isItemInFavorites(widget.item.name);
    setState(() {
      isInFavorites = isFavorite;
    });
  }

  // Add or remove the item from favorites
  void addToFavorites() async {
    final favoriteItem = FavoriteItem(
      name: widget.item.name,
      imagePath: widget.item.imagePath,
      price: widget.item.price,
    );

    if (isInFavorites) {
      // If the item is already in favorites, remove it
      await dbHelper.deleteFavoriteItem(widget.item.name);
    } else {
      // If the item is not in favorites, add it
      await dbHelper.insertFavoriteItem(favoriteItem);
    }

    // Toggle the isInFavorites variable
    setState(() {
      isInFavorites = !isInFavorites;
    });
  }

  // Decrease the quantity of the item in the cart
  void decrementQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  // Increase the quantity of the item in the cart
  void incrementQuantity() {
    setState(() {
      quantity++;
    });
  }

  // Add the item to the cart
  Future<void> addToCart() async {
    final name = widget.item.name;
    final itemPrice = widget.item.price;
    final itemImagePath = widget.item.imagePath;
    final itemQuantity = quantity;

    // Check if the item already exists in the cart
    final cartItem = await dbHelper.getCartItemByName(name);

    if (cartItem != null) {
      // Show a confirmation dialog if the item is already in the cart
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Item Already in Cart'),
            content: const Text('Do you want to add the same item again?'),
            actions: [
              TextButton(
                onPressed: () {
                  // Cancel and go back to the grocery list
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GroceryList(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  // Add the item to the cart again
                  await dbHelper.insertCartItem(CartItem(
                    name: name,
                    price: itemPrice,
                    imagePath: itemImagePath,
                    quantity: itemQuantity,
                    item: widget.item,
                  ));

                  // Close the dialog and navigate to the cart
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => CartPage()),
                    (route) => false,
                  );
                },
                child: const Text('Add Again'),
              ),
            ],
          );
        },
      );
    } else {
      // If the item doesn't exist in the cart, add it
      await dbHelper.insertCartItem(CartItem(
        name: name,
        price: itemPrice,
        imagePath: itemImagePath,
        quantity: itemQuantity,
        item: widget.item,
      ));

      // Navigate to the cart
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => CartPage()),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item.name),
        actions: [
          IconButton(
            icon: Icon(
              isInFavorites ? Icons.favorite : Icons.favorite_border,
              color: isInFavorites ? Colors.red : null,
            ),
            onPressed: addToFavorites,
          ),
        ],
      ),
      drawer: appDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  widget.item.imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.item.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Price: \$${widget.item.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: decrementQuantity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '$quantity',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: incrementQuantity,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: addToCart,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined),
              SizedBox(width: 10),
              Text(
                'Add to Cart',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
