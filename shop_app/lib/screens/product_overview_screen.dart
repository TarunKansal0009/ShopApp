import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import '../widgets/product_grid.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';

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
          Consumer<Cart>(
            builder: (_, cart, ch) =>
                Badge(child: ch, value: cart.itemCount.toString()),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      body: ProductGrid(_showFavorite),
    );
  }
}
