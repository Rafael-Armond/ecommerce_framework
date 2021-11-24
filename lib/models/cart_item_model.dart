import 'package:flutter_firebase_ecommerce/models/product_model.dart';

class CartItemModel {
  String id;
  ProductModel product;
  int quantity;
  double totalItemPrice;

  CartItemModel(
      {required this.id,
      required this.product,
      required this.quantity,
      required this.totalItemPrice});
}
