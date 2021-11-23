import 'package:flutter_firebase_ecommerce/controllers/cart_controller.dart';
import 'package:flutter_firebase_ecommerce/models/cart_item_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingCartItem extends StatelessWidget {
  final CartItemModel cartItem;

  ShoppingCartItem({Key? key, required this.cartItem}) : super(key: key);

  final CartController _cartController = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(cartItem.product.image, width: 60),
      title: Text(
        cartItem.product.name,
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        'R\$ ${cartItem.product.price.toStringAsFixed(2)}',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: const Icon(Icons.chevron_left, size: 30),
                  onPressed: cartItem.quantity > 1
                      ? () => _cartController.decreaseItemQuantity(cartItem)
                      : null),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  cartItem.quantity.toString(),
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.chevron_right, size: 30),
                  onPressed: () =>
                      _cartController.increaseItemQuantity(cartItem)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _cartController.removeItemFromCart(cartItem),
          ),
        ],
      ),
    );
  }
}
