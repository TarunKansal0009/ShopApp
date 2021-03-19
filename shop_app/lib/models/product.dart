import 'dart:ffi';

import 'package:flutter/cupertino.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final Double price;
  final String imageurl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.description,
    @required this.title,
    @required this.price,
    @required this.imageurl,
     this.isFavorite=false,
  });
}
