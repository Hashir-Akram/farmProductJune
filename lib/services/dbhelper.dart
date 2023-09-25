import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/userTable.dart';

class DatabaseHelper {
  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._();

  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final databasePath = await getDatabasesPath();

    final database = await openDatabase(
      join(databasePath, 'app_database.db'),
      version: 1,
      onCreate: _createDatabase,
    );

    return database;
  }

  void _createDatabase(Database db, int version) async {
    // Create 'users' table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT NOT NULL,
        password TEXT NOT NULL,
        firstname TEXT NOT NULL,
        lastname TEXT NOT NULL
      )
    ''');

    // Create 'item' table
    await db.execute('''
      CREATE TABLE item (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT NOT NULL
      )
    ''');

    // Create 'cart' table
    await db.execute('''
      CREATE TABLE cart (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        price REAL NOT NULL,
        imagePath TEXT NOT NULL,
        quantity INTEGER NOT NULL
      )
    ''');

    // Create 'favorite_table'
    await db.execute('''
    CREATE TABLE favoriteTable (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL UNIQUE,
      price REAL NOT NULL,
      imagePath TEXT NOT NULL
    )
  ''');
  }

  // Add methods for managing user details
  Future<List<Map<String, dynamic>>> getUsers() async {
    final dbClient = await database;
    return await dbClient.query('users');
  }

  Future<void> updateUser(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    final dbClient = await database;
    await dbClient.update(
      'users',
      {
        'firstname': firstName,
        'lastname': lastName,
        'username': email,
        'password': password,
      },
      where: 'id = ?',
      whereArgs: [1],
    );
  }

  Future<bool> doesEmailExist(String email) async {
    final db = await instance.database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM users WHERE username = ?',
      [email],
    ));
    return count != null && count > 0;
  }

  Future<void> updatePassword(String email, String newPassword) async {
    final db = await instance.database;
    await db.update(
      'users',
      {'password': newPassword},
      where: 'username = ?',
      whereArgs: [email],
    );
  }

  // Add methods for managing cart items
  Future<void> productAdd(String name, String imagePath, double price) async {
    final db = await database;
    await db.insert(
      'item',
      {
        'name': name,
        'price': price,
        'imagePath': imagePath,
      },
    );
  }

  Future<void> insertCartItem(CartItem cartItem) async {
    final db = await database;
    await db.insert('cart', cartItem.toMap());
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cart');
    return List.generate(maps.length, (i) {
      return CartItem(
        name: maps[i]['name'],
        item: Item(
          name: maps[i]['name'],
          imagePath: maps[i]['imagePath'],
          price: maps[i]['price'],
        ),
        quantity: maps[i]['quantity'],
        price: maps[i]['price'],
        imagePath: maps[i]['imagePath'],
      );
    });
  }

  Future<void> updateCartItem(CartItem cartItem) async {
    final db = await database;
    await db.update(
      'cart',
      cartItem.toMap(),
      where: 'name = ?', // Use item name for updating
      whereArgs: [cartItem.name],
    );
  }

  Future<void> deleteCartItem(String name) async {
    final db = await database;
    await db.delete(
      'cart',
      where: 'name = ?', // Use item name for deleting
      whereArgs: [name],
    );
  }

  // Custom method to get a cart item by name
  Future<CartItem?> getCartItemByName(String name) async {
    final db = await initDatabase();
    final List<Map<String, dynamic>> maps = await db.query(
      'cart',
      where: 'name = ?',
      whereArgs: [name],
    );

    if (maps.isNotEmpty) {
      return CartItem.fromMap(maps.first);
    } else {
      return null;
    }
  }

  // Add methods for managing favorite items
  Future<void> insertFavoriteItem(FavoriteItem item) async {
    final db = await instance.database;
    await db.insert(
      'favoriteTable',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<FavoriteItem>> getFavoriteItems() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query('favoriteTable');
    return List.generate(maps.length, (i) {
      return FavoriteItem(
        name: maps[i]['name'],
        imagePath: maps[i]['imagePath'],
        price: maps[i]['price'],
      );
    });
  }

  Future<void> deleteFavoriteItem(String name) async {
    final db = await database;
    await db.delete(
      'favoriteTable',
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<bool> isItemInFavorites(String itemName) async {
    final db = await database;
    final count = Sqflite.firstIntValue(await db.rawQuery(
      'SELECT COUNT(*) FROM favoriteTable WHERE name = ?',
      [itemName],
    ));
    return count != null && count > 0;
  }
}
