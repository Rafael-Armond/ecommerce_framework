import 'package:flutter_firebase_ecommerce/views/cart/cart_item_view.dart';
import 'package:flutter_firebase_ecommerce/controllers/cart_controller.dart';
import 'package:flutter_firebase_ecommerce/views/shared/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartModal extends StatelessWidget {
  ShoppingCartModal({Key? key}) : super(key: key);

  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: Get.width * 0.025),
          child: const Text(
            'Carrinho de compras',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.75,
          child: Obx(
            () => ListView(
              children: _cartController.cartItens
                  .map((cartItem) => Column(
                        children: [
                          ShoppingCartItem(
                            cartItem: cartItem,
                          ),
                          const Divider(),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Obx(
            () => ElevatedButton(
              onPressed: _cartController.cartItens.isNotEmpty
                  ? () async => Utils.generatePDF(_cartController.cartItens,
                      _cartController.totalCartPrice.value)
                  : null,
              child: Text(
                'Finalizar (PDF) - R\$ ${_cartController.totalCartPrice.value.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),
        )
      ],
    );
  }
}
