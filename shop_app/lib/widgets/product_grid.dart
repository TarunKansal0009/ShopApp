import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showfavs;
  ProductGrid(this.showfavs);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = showfavs ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ChangeNotifierProvider(
        create: (context) => products[index],
        child: ProductItem(
            // product[index].id,
            // product[index].imageUrl,
            // product[index].title,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 5,
        crossAxisCount: 2,
        childAspectRatio: 2 / 1.5,
        mainAxisSpacing: 10,
      ),
    );
  }
}
