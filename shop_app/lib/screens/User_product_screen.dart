import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/drawer.dart';
import '../providers/products.dart';
import '../widgets/User_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Articles'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
          itemCount: productsdata.items.length,
          itemBuilder: (_, i) => Column(
            children: [
              UserProductItem(
                  productsdata.items[i].title, productsdata.items[i].imageUrl),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
