import 'package:flutter_firebase_ecommerce/repositories/products_repository.dart';
import 'package:flutter_firebase_ecommerce/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  ProductsController(this._productsRepository);
  final ProductsRepository _productsRepository;

  Rx<String> searchProductTerm = ''.obs;

  RxList<ProductModel> allProducts = <ProductModel>[].obs;

  Future<void> getAllProducts() async {
    allProducts.assignAll(await _productsRepository.getAllProducts());
  }

  List<ProductModel> get displayedProducts => searchProductTerm.value.isEmpty
      ? allProducts
      : allProducts
          .where((product) => product.name
              .toLowerCase()
              .contains(searchProductTerm.value.toLowerCase()))
          .toList();

  void clearController() {
    searchProductTerm = ''.obs;
    allProducts = <ProductModel>[].obs;
  }
}
