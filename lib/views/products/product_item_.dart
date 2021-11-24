import 'package:flutter_firebase_ecommerce/controllers/cart_controller.dart';
import 'package:flutter_firebase_ecommerce/models/product_model.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;

  ProductItem(this.product, {Key? key}) : super(key: key);

  final CartController _cartController = Get.find();

  final double screenWidth = Get.width;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      shadowColor: Colors.black.withOpacity(.5),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: screenWidth * 0.01),
            child: Text(
              product.name,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
              // style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenWidth * 0.01),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network(
                product.image,
                scale: Get.size.aspectRatio * 0.65,
                height: Get.size.height * 0.07,
                filterQuality: FilterQuality.none,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'R\$ ${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Obx(
            () => Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              child: ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_cartController.cartItens
                            .any((element) => element.id == product.id)
                        ? 'Remover'
                        : 'Add to cart'),
                    Icon(_cartController.cartItens
                            .any((element) => element.id == product.id)
                        ? Icons.remove_shopping_cart
                        : Icons.add_shopping_cart),
                  ],
                ),
                onPressed: _cartController.cartItens
                        .any((element) => element.id == product.id)
                    ? () => _cartController.removeItemToCart(product)
                    : () => _cartController.addItemToCart(product),
              ),
            ),
          )
        ],
      ),
    );
  }
}
