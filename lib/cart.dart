import 'package:faramproduct/productPreview.dart';
import 'package:faramproduct/drawer.dart';
import 'package:faramproduct/groceryList.dart';
import 'package:faramproduct/services/dbhelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../model/userTable.dart';

class CartPage extends StatefulWidget {
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  CartPage({Key? key}) : super(key: key);

  @override
  CartPageState createState() => CartPageState();
}

class CartPageState extends State<CartPage> {
  late Future<List<CartItem>> cartItemsFuture;

  @override
  void initState() {
    super.initState();
    cartItemsFuture = widget.dbHelper.getCartItems();
  }

  void sortCartItemsAlphabetically(List<CartItem>? cartItems) {
    if (cartItems != null) {
      cartItems.sort((a, b) => a.item.name.compareTo(b.item.name));
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final confirmExit = await showDialog(
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
                  Navigator.pop(context, false);
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
        return confirmExit ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text('Cart'),
        ),
        drawer: appDrawer(context),
        body: FutureBuilder<List<CartItem>>(
          future: cartItemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No items in the cart.'));
            } else {
              final cartItems = snapshot.data;

              sortCartItemsAlphabetically(cartItems);

              double totalAmount = cartItems!.fold<double>(
                0,
                    (previousValue, cartItem) =>
                previousValue + (cartItem.price * cartItem.quantity),
              );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final cartItem = cartItems[index];
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the product preview page with the selected item
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductPreview(item: cartItem.item),
                              ),
                            );
                          },
                          child: CartItemCard(
                            cartItem: cartItem,
                            onDelete: () async {
                              await widget.dbHelper.deleteCartItem(cartItem.name);
                              setState(() {
                                cartItems.removeAt(index);
                              });
                            },
                            onQuantityChanged: (newQuantity) {
                              cartItem.quantity = newQuantity;
                              widget.dbHelper.updateCartItem(cartItem);
                              setState(() {});
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const GroceryList(),
                                    ),
                                        (route) => false,
                                  );
                                },
                                child: const Text(
                                  'Continue Shopping',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Buy Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class CartItemCard extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onDelete;
  final ValueChanged<int> onQuantityChanged;

  const CartItemCard({super.key,
    required this.cartItem,
    required this.onDelete,
    required this.onQuantityChanged,
  });

  double getTotalPrice() {
    return cartItem.price * cartItem.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    cartItem.item.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 24,
                  ),
                  onPressed: onDelete,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 6,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        cartItem.item.imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Price: \$${getTotalPrice().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                color: Colors.blue,
                                onPressed: () {
                                  if (cartItem.quantity > 1) {
                                    onQuantityChanged(cartItem.quantity - 1);
                                  }
                                },
                              ),
                              Text(
                                '${cartItem.quantity}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add),
                                color: Colors.blue,
                                onPressed: () {
                                  onQuantityChanged(cartItem.quantity + 1);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
