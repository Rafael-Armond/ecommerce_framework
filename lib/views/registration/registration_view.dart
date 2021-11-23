import 'package:flutter_firebase_ecommerce/controllers/authentication_controller.dart';
import 'package:flutter_firebase_ecommerce/views/shared/widgets/loading_widget.dart';
import 'package:flutter_firebase_ecommerce/views/shared/widgets/text_form.dart';
import 'package:flutter_firebase_ecommerce/views/shared/util/util.dart';
import 'package:flutter_firebase_ecommerce/views/login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);

  final AuthenticationController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenWidth = Get.width;
    return WillPopScope(
      onWillPop: () async {
        _authController.clearController();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cadastro'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: FractionallySizedBox(
              widthFactor: 0.75,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: screenWidth * 0.05),
                    child: const Text(
                      '- Digite um E-mail válido\n'
                      '- A Senha deve conter no mínimo 6 caracteres',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenWidth * 0.025),
                    child: TextForm(
                        labelText: 'Digite o seu email',
                        onChanged: (String text) =>
                            _authController.email.value = text),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenWidth * 0.025),
                    child: TextForm(
                      labelText: 'Digite a sua senha',
                      onChanged: (String text) =>
                          _authController.password.value = text,
                      isObscured: true,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: screenWidth * 0.025),
                    child: TextForm(
                      labelText: 'Confirme a sua senha',
                      onChanged: (String text) =>
                          _authController.confirmPassword.value = text,
                      isObscured: true,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: screenWidth * 0.1),
                    child: Obx(
                      () => ElevatedButton(
                        child: const Text('Criar conta'),
                        onPressed: _authController.isCadastroPreenchido
                            ? () async {
                                LoadingWidget.show(context);
                                await _authController.signUp().then((sucess) {
                                  if (sucess) {
                                    Get.off(() => LoginView());
                                    Utils.showSucessSnackbar(
                                        title:
                                            'Sua conta foi criada com sucesso!',
                                        message:
                                            'Utilize seu email e senha para logar no aplicativo.');
                                  }
                                });
                                LoadingWidget.suppress();
                              }
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
