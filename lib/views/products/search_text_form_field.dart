import 'package:flutter_firebase_ecommerce/controllers/products_controller.dart';
import 'package:flutter/material.dart';

class SearchTextFormField extends StatelessWidget {
  const SearchTextFormField({
    Key? key,
    required ProductsController productsController,
  })  : _productsController = productsController,
        super(key: key);

  final ProductsController _productsController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        label: Text('Pesquisar produto'),
        labelStyle: TextStyle(fontSize: 14, color: Colors.blueAccent),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blueAccent,
          ),
        ),
      ),
      autofocus: false,
      textInputAction: TextInputAction.search,
      controller: _productsController.searchProductController,
      onChanged: (String text) =>
          _productsController.searchProductTerm.value = text,
    );
  }
}
