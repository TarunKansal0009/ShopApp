import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/widgets/product_item.dart';


class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 5,
        crossAxisCount: 1,
        childAspectRatio: 3 / 1.5,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider(
        create: (context)=> products[index],
        child: ProductItem(
            // product[index].id,
            // product[index].imageUrl,
            // product[index].title,
            ),
      ),
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
    );
  }
}
