import 'package:flutter_firebase_ecommerce/controllers/authentication_controller.dart';
import 'package:flutter_firebase_ecommerce/repositories/products_repository.dart';
import 'package:flutter_firebase_ecommerce/controllers/products_controller.dart';
import 'package:flutter_firebase_ecommerce/repositories/user_repository.dart';
import 'package:flutter_firebase_ecommerce/controllers/cart_controller.dart';
import 'package:get/instance_manager.dart';

void dependencyManagement() {
  // Repositories0
  Get.put(UserRepository());
  Get.put(ProductsRepository());

  //Stores
  Get.put(AuthenticationController(Get.find<UserRepository>()));
  Get.put(ProductsController(Get.find<ProductsRepository>()));
  Get.put(CartController());
}
