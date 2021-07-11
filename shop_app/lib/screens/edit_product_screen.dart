import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: null,
    description: '',
    title: '',
    price: 0,
    imageUrl: '',
  );
  var _initValues = {
    'title': '',
    'price': '',
    'description': '',
    'imageUrl': '',
  };
  var _isInit = true;
  var _isloading = false;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId != null) {
        _editedProduct =
            Provider.of<Products>(context, listen: false).findById(productId);
      }

      _initValues = {
        'title': _editedProduct.title,
        'price': _editedProduct.price.toString(),
        'description': _editedProduct.description,
        'imageUrl': '',
      };
      _imageUrlController.text = _editedProduct.imageUrl;
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isloading = true;
    });
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false).updateProduct(
        _editedProduct.id,
        _editedProduct,
      );
      setState(() {
        _isloading = false;
      });
      Navigator.of(context).pop();
    } else {
      Provider.of<Products>(context, listen: false)
          .addProduct(_editedProduct)
          .catchError((error) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occured!'),
            content: Text('Something went wrong!'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('OKAY'))
            ],
          ),
        );
      }).then((_) {
        setState(() {
          _isloading = false;
        });
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Article'),
        actions: <Widget>[
          IconButton(onPressed: _saveForm, icon: Icon(Icons.save))
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  TextFormField(
                      initialValue: _initValues['title'],
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(labelText: 'Title'),
                      onSaved: (value) {
                        _editedProduct = Product(
                          title: value,
                          price: _editedProduct.price,
                          imageUrl: _editedProduct.imageUrl,
                          description: _editedProduct.description,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please provide a title';
                        }

                        return null;
                      }),
                  TextFormField(
                    initialValue: _initValues['price'],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_priceFocusNode);
                    },
                    onSaved: (value) {
                      _editedProduct = Product(
                        title: _editedProduct.title,
                        price: double.parse(value),
                        imageUrl: _editedProduct.imageUrl,
                        description: _editedProduct.description,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: _initValues['description'],
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    keyboardType: TextInputType.multiline,
                    onSaved: (value) {
                      _editedProduct = Product(
                        title: _editedProduct.title,
                        price: _editedProduct.price,
                        imageUrl: _editedProduct.imageUrl,
                        description: value,
                        id: _editedProduct.id,
                        isFavorite: _editedProduct.isFavorite,
                      );
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.only(
                          top: 10,
                          right: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.grey,
                          ),
                        ),
                        child: _imageUrlController.text.isEmpty
                            ? Text('Enter a Url')
                            : FittedBox(
                                child: Image.network(
                                  _imageUrlController.text,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Image Url',
                          ),
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          onFieldSubmitted: (_) => _saveForm(),
                          onSaved: (value) {
                            _editedProduct = Product(
                              title: _editedProduct.title,
                              price: _editedProduct.price,
                              imageUrl: value,
                              description: _editedProduct.description,
                              id: _editedProduct.id,
                              isFavorite: _editedProduct.isFavorite,
                            );
                          },
                        ),
                      )
                    ],
                  )
                ],
              )),
    );
  }
}
