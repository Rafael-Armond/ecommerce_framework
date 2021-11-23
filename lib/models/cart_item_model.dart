import 'package:flutter_firebase_ecommerce/models/product_model.dart';

class CartItemModel {
  ProductModel product;
  int quantity;
  double totalItemPrice;
  String id;

  CartItemModel(
      {required this.product,
      required this.quantity,
      required this.totalItemPrice,
      required this.id});
}
