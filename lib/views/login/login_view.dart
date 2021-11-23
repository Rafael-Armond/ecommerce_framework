import 'package:flutter_firebase_ecommerce/controllers/authentication_controller.dart';
import 'package:flutter_firebase_ecommerce/views/registration/registration_view.dart';
import 'package:flutter_firebase_ecommerce/views/shared/widgets/loading_widget.dart';
import 'package:flutter_firebase_ecommerce/controllers/products_controller.dart';
import 'package:flutter_firebase_ecommerce/views/shared/widgets/text_form.dart';
import 'package:flutter_firebase_ecommerce/views/products/products_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final AuthenticationController _authController = Get.find();
  final ProductsController _productsController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: TextForm(
                        labelText: 'E-mail',
                        onChanged: (String text) =>
                            _authController.email.value = text),
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: TextForm(
                      labelText: 'Senha',
                      onChanged: (String text) =>
                          _authController.password.value = text,
                      isObscured: true,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.1),
                child: Obx(
                  () => ElevatedButton(
                    child: const Text('Entrar'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                      shadowColor: Colors.black,
                    ),
                    onPressed: _authController.isEmailSenhaPreenchidos
                        ? () async {
                            LoadingWidget.show(context);
                            await _authController.signIn().then((sucess) async {
                              if (sucess) {
                                await _productsController.getAllProducts();
                                Get.off(() => ProductsView());
                              }
                            });
                            LoadingWidget.suppress();
                          }
                        : null,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: screenWidth * 0.025),
                child: TextButton(
                  child: const Text('Cadastrar'),
                  onPressed: () => Get.to(() => SignupView()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
