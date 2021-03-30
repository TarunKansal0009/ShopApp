import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IET STUDENT CHAPTER'),
        
        actions: <Widget>[
          PopupMenuButton(
              onSelected: (FilterOptions selectedValue) {
                setState(() {
                  if (selectedValue == FilterOptions.Favorites) {
                    _showFavorite = true;
                  } else {
                    _showFavorite = false;
                  }
                });
              },
              itemBuilder: (ctx) => [
                    PopupMenuItem(
                      child: Text('Favorite Articles'),
                      value: FilterOptions.Favorites,
                    ),
                    PopupMenuItem(
                      child: Text('All Articles'),
                      value: FilterOptions.All,
                    )
                  ],
              icon: Icon(
                Icons.more_vert,
              )),
              Icon(Icons.shopping_cart),
        ],
      
      ),
      
      body: ProductGrid(_showFavorite),
    );
  }
}
