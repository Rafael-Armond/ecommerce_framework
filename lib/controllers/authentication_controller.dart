import 'package:flutter_firebase_ecommerce/repositories/user_repository.dart';
import 'package:flutter_firebase_ecommerce/views/shared/util/util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  Rx<String> email = ''.obs;
  Rx<String> password = ''.obs;
  Rx<String> confirmPassword = ''.obs;

  bool _isLoggedIn = false;

  final UserRepository _userRepository;

  bool get isEmailSenhaPreenchidos =>
      email.value.isNotEmpty && password.value.isNotEmpty;

  bool get isCadastroPreenchido =>
      email.value.isNotEmpty &&
      password.value.isNotEmpty &&
      confirmPassword.value.isNotEmpty;

  AuthenticationController(this._userRepository);

  Future<bool> signIn() async {
    await _userRepository
        .authenticateUser(email.value, password.value)
        .then((isUserAuthenticated) {
      if (isUserAuthenticated) {
        clearController();
        _isLoggedIn = true;
      }
    });
    return _isLoggedIn;
  }

  void signOut() async {
    _isLoggedIn = false;
  }

  Future<bool> signUp() async {
    if (password.value != confirmPassword.value) {
      Utils.showErrorSnackbar(
          title: 'As senhas não conferem:',
          message: 'Certifique-se de que as senhas digitadas são iguais.');
      return false;
    }
    bool isUserRegistered =
        await _userRepository.registerUser(email.value, password.value);
    if (isUserRegistered) clearController();
    return isUserRegistered;
  }

  void clearController() {
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    email.value = '';
    password.value = '';
    confirmPassword.value = '';
  }
}
