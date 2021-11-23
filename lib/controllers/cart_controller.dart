import 'package:flutter_firebase_ecommerce/models/cart_item_model.dart';
import 'package:flutter_firebase_ecommerce/models/product_model.dart';
import 'package:get/state_manager.dart';

class CartController extends GetxController {
  RxList<CartItemModel> cartItens = <CartItemModel>[].obs;

  void addItemToCart(ProductModel product) {
    cartItens.add(CartItemModel(
        product: product,
        quantity: 1,
        totalItemPrice: product.price,
        id: product.id));
  }

  void removeItemToCart(ProductModel product) {
    cartItens.removeWhere((item) => item.product.id == product.id);
  }

  void removeItemFromCart(CartItemModel cartItem) {
    int itemIndex = cartItens.indexWhere((item) => item.id == cartItem.id);
    if (itemIndex != -1) {
      cartItens.removeAt(itemIndex);
      cartItens.refresh();
    }
  }

  Rx<double> get totalCartPrice =>
      cartItens.fold<double>(0, (prev, item) => prev + item.totalItemPrice).obs;

  void increaseItemQuantity(CartItemModel cartItem) {
    int itemIndex = cartItens.indexWhere((item) => item.id == cartItem.id);
    if (itemIndex != -1) {
      cartItens[itemIndex].quantity++;
      cartItens[itemIndex].totalItemPrice += cartItem.product.price;
      cartItens.refresh();
    }
  }

  void decreaseItemQuantity(CartItemModel cartItem) {
    int itemIndex = cartItens.indexWhere((item) => item.id == cartItem.id);
    if (itemIndex != -1) {
      cartItens[itemIndex].quantity--;
      cartItens[itemIndex].totalItemPrice -= cartItem.product.price;
      cartItens.refresh();
    }
  }

  void clearController() {
    cartItens = <CartItemModel>[].obs;
  }
}
