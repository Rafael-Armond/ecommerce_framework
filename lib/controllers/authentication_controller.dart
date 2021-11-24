import 'package:flutter_firebase_ecommerce/controllers/cart_controller.dart';
import 'package:flutter_firebase_ecommerce/controllers/products_controller.dart';
import 'package:flutter_firebase_ecommerce/repositories/user_repository.dart';
import 'package:flutter_firebase_ecommerce/views/shared/util/util.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  AuthenticationController(this._userRepository);

  Rx<String> email = ''.obs;
  Rx<String> password = ''.obs;
  Rx<String> confirmPassword = ''.obs;

  final UserRepository _userRepository;

  Future<void> signIn() async {
    await _userRepository.authenticateUser(email.value, password.value);
  }

  Future<void> signOut() async {
    ProductsController _productsController = Get.find();
    CartController _cartController = Get.find();
    _productsController.clearController();
    _cartController.clearController();
    clearController();

    return await _userRepository.singOutUser();
  }

  Future<bool> signUp() async {
    if (password.value != confirmPassword.value) {
      Utils.showErrorSnackbar(
          title: 'As senhas estão diferentes',
          message: 'Certifique-se de que as senhas digitadas são iguais.');
      return false;
    }
    bool isUserRegistered =
        await _userRepository.registerUser(email.value, password.value);
    if (isUserRegistered) clearController();
    return isUserRegistered;
  }

  void clearController() {
    email.value = '';
    password.value = '';
    confirmPassword.value = '';
  }
}
