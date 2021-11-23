import 'package:flutter_firebase_ecommerce/models/product_model.dart';

abstract class IProductsRepository {
  Future<List<ProductModel>> getAllProducts();
}
