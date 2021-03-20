import 'package:flutter/material.dart';
import 'package:shop_app/widgets/product_item.dart';  
import '../models/product.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IET STUDENT CHAPTER'),
      ),
      body: ProductGrid(),
    );
  }
}

