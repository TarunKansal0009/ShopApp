import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IET STUDENT CHAPTER'),
        actions: <Widget>[
          PopupMenuButton(
              itemBuilder: (ctx) => [PopupMenuItem(child: Text('Favorites'))],
              icon: Icon(
                Icons.more_vert,
              ))
        ],
      ),
      body: ProductGrid(),
    );
  }
}
