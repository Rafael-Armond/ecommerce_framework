import 'package:flutter_firebase_ecommerce/controllers/authentication_controller.dart';
import 'package:flutter_firebase_ecommerce/views/products/search_text_form_field.dart';
import 'package:flutter_firebase_ecommerce/views/shared/widgets/cart_buttom.dart';
import 'package:flutter_firebase_ecommerce/controllers/products_controller.dart';
import 'package:flutter_firebase_ecommerce/views/cart/shopping_cart_modal.dart';
import 'package:flutter_firebase_ecommerce/views/products/product_item_.dart';
import 'package:flutter_firebase_ecommerce/controllers/cart_controller.dart';
import 'package:flutter_firebase_ecommerce/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductsView extends StatelessWidget {
  ProductsView({Key? key}) : super(key: key);

  final ProductsController _productsController = Get.find();
  final CartController _cartController = Get.find();
  final AuthenticationController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Produtos',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          Obx(
            () => ActionButtom(
              onPressed: () => showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (context) => FractionallySizedBox(
                  heightFactor: 0.9,
                  child: Container(
                    color: Colors.white,
                    child: ShoppingCartModal(),
                  ),
                ),
              ),
              counterIndicator: _cartController.cartItens.length,
            ),
          ),
        ],
        leading: IconButton(
          padding: EdgeInsets.only(left: screenWidth * 0.025),
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
          onPressed: () {
            _productsController.clearController();
            _cartController.clearController();
            _authController.signOut();
            Get.off(() => LoginView());
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06,
                  vertical: screenWidth * 0.02,
                ),
                child: SearchTextFormField(
                    productsController: _productsController),
              ),
              GridView.count(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                childAspectRatio: 1,
                padding: EdgeInsets.all(screenWidth * 0.025),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: screenWidth * 0.025,
                children: _productsController.displayedProducts.map((product) {
                  return ProductItem(product);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
