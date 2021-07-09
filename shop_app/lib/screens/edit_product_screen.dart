import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _DescriptionFocusNode = FocusNode();
  @override
  void dispose() {
    _priceFocusNode.dispose();
    _DescriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Article'),
      ),
      body: Form(
          child: ListView(
        children: <Widget>[
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Price'),
            keyboardType: TextInputType.number,
            focusNode: _priceFocusNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_priceFocusNode);
            },
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
            focusNode: _DescriptionFocusNode,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(_DescriptionFocusNode);
            },
            keyboardType: TextInputType.multiline,
          )
        ],
      )),
    );
  }
}
