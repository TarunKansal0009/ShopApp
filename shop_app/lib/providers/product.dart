import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.description,
    @required this.title,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });
  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://article-app-c40ae-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.patch(Uri.parse(url),
          body: json.encode({
            'isFavorite': isFavorite,
          }));
      if (response.statusCode >= 400) {
        isFavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
