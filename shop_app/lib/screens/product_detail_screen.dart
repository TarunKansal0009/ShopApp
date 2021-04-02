import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail page';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 30),
            Text(
              loadedProduct.title,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 25,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Rs. ${loadedProduct.price}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                '${loadedProduct.description}',
                textAlign: TextAlign.center,
                softWrap: true,
                textScaleFactor: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
