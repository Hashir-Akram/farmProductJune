// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faramproduct/productPreview.dart';
import 'package:faramproduct/model/userTable.dart';
import 'package:faramproduct/services/dbhelper.dart';
import 'package:faramproduct/drawer.dart';
import 'cart.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  FavoritePageState createState() => FavoritePageState();
}

class FavoritePageState extends State<FavoritePage> {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  List<FavoriteItem> favoriteItems = [];

  Set<int> selectedItems = <int>{};
  bool selectAll = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteItems();
  }

  //Sort the items alphabetically
  void sortFavoriteItemsAlphabetically(List<FavoriteItem>? favoriteItems) {
    if (favoriteItems != null) {
      favoriteItems.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  // Load favorite items when the widget initializes
  Future<void> _loadFavoriteItems() async {
    final items = await dbHelper.getFavoriteItems();
    sortFavoriteItemsAlphabetically(items); // Sort the items here
    setState(() {
      favoriteItems = items;
    });
  }

  // Handle back button press
  Future<bool> _onBackPressed() async {
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
  }

  // Add selected items to the cart
  void _addToCartSelectedItems() async {
    if (selectedItems.isEmpty) {
      return;
    }

    for (int index in selectedItems) {
      final item = favoriteItems[index];
      final cartItem = await dbHelper.getCartItemByName(item.name);

      if (cartItem != null) {
        // Item is already in the cart, you can prompt the user if they want to add it again
        bool addToCartAgain = await _showAddToCartAgainDialog(item.name);
        if (!addToCartAgain) {
          continue; // Skip this item if the user doesn't want to add it again
        }
      }

      await dbHelper.insertCartItem(
        CartItem(
          name: item.name,
          price: item.price,
          imagePath: item.imagePath,
          quantity: 1,
          item: Item(
            name: item.name,
            imagePath: item.imagePath,
            price: item.price,
          ),
        ),
      );
    }

    final itemsToRemove = selectedItems.map((index) => favoriteItems[index]).toList();

    for (FavoriteItem item in itemsToRemove) {
      await dbHelper.deleteFavoriteItem(item.name);
      favoriteItems.remove(item);
    }

    selectedItems.clear();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartPage(),
      ),
    );
  }

  Future<bool> _showAddToCartAgainDialog(String itemName) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add to Cart"),
        content: Text("'$itemName' is already in the cart. Do you want to add it again?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Do not add it again
            },
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Add it again
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    ) ?? false; // Default to false if the dialog is dismissed
  }

  // Remove selected items from favorites
  void _removeFromFavoritesSelectedItems() async {
    List<int> indexesToRemove = selectedItems.toList();
    indexesToRemove.sort((a, b) => b.compareTo(a));
    for (int index in indexesToRemove) {
      final item = favoriteItems[index];
      await dbHelper.deleteFavoriteItem(item.name);
    }
    favoriteItems.removeWhere(
            (item) => selectedItems.contains(favoriteItems.indexOf(item)));
    selectedItems.clear();
    selectAll = false;

    setState(() {});
  }

  // Check if all items are selected
  bool _areAllItemsSelected() {
    return favoriteItems.isNotEmpty && selectedItems.length == favoriteItems.length;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text('Favorite Item'),
          actions: [
            Checkbox(
              checkColor: Colors.blue,
              activeColor: Colors.white,
              value: _areAllItemsSelected(),
              onChanged: (value) {
                setState(() {
                  selectAll = value!;
                  if (selectAll) {
                    for (int i = 0; i < favoriteItems.length; i++) {
                      selectedItems.add(i);
                    }
                  } else {
                    selectedItems.clear();
                  }
                });
              },
            ),
          ],
        ),
        drawer: appDrawer(context),
        body: Column(
          children: [
            Expanded(child: _buildFavoriteList()),
            if (selectedItems.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _removeFromFavoritesSelectedItems,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                    ),
                    child: const Text("Remove from Favorites"),
                  ),
                  ElevatedButton(
                    onPressed: _addToCartSelectedItems,
                    child: Text("Add to Cart (${selectedItems.length})"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  // Widget to display the list of favorite items
  Widget _buildFavoriteList() {
    if (favoriteItems.isEmpty) {
      return const Center(
        child: Text("You have no favorite items."),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteItems.length,
        itemBuilder: (context, index) {
          final item = favoriteItems[index];
          return GestureDetector(
            onTap: () {
              if (selectedItems.isEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductPreview.fromFavorite(
                      favoriteItem: item,
                    ),
                  ),
                );
              } else {
                setState(() {
                  if (selectedItems.contains(index)) {
                    selectedItems.remove(index);
                  } else {
                    selectedItems.add(index);
                  }
                });
              }
            },
            onLongPress: () {
              setState(() {
                if (selectedItems.contains(index)) {
                  selectedItems.remove(index);
                } else {
                  selectedItems.add(index);
                }
              });
            },
            child: _buildFavoriteItem(item, index),
          );
        },
      );
    }
  }

  // Widget to build each favorite item
  Widget _buildFavoriteItem(FavoriteItem item, int index) {
    bool isSelected = selectedItems.contains(index);

    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(item.name),
        subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
        leading: Image.asset(item.imagePath, height: 50, width: 50),
        trailing: isSelected
            ? const Icon(Icons.check_circle, color: Colors.green)
            : null,
      ),
    );
  }
}
