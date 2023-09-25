// Define a User class
class User {
  int? id;
  String username;
  String password;
  String firstname;
  String lastname;

  User(
      {this.id,
      required this.username,
      required this.password,
      required this.firstname,
      required this.lastname});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'firstname': firstname,
      'lastname': lastname,
    };
  }
}

// Define an Item class
class Item {
  final String name;
  final String imagePath;
  final double price;

  Item({
    required this.name,
    required this.imagePath,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imagePath': imagePath,
      'price': price,
    };
  }
}

// Define a CartItem class
class CartItem {
  final String name;
  final Item item;
  final double price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.name,
    required this.item,
    required this.price,
    required this.imagePath,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'imagePath': imagePath,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      name: map['name'],
      item: Item(
        name: map['name'],
        imagePath: map['imagePath'],
        price: map['price'],
      ),
      price: map['price'],
      imagePath: map['imagePath'],
      quantity: map['quantity'],
    );
  }
}

// Create a new model for Favorite items
class FavoriteItem {
  final String name;
  final String imagePath;
  final double price;

  FavoriteItem({
    required this.name,
    required this.imagePath,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'imagePath': imagePath,
    };
  }
}
