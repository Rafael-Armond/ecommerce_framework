import 'package:flutter_firebase_ecommerce/repositories/interfaces/i_user_repository.dart';
import 'package:flutter_firebase_ecommerce/views/shared/util/util.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository implements IUserRepository {
  @override
  Future<bool> authenticateUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      Utils.showErrorSnackbar(
          title: 'Falha na autenticação', message: 'Confira as credenciais');
      return false;
    }
  }

  @override
  Future<void> singOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<bool> registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Utils.showErrorSnackbar(
            title: 'Email já cadastrado:',
            message: 'Já existe um usuário cadastrado para esse email.');
      } else if (e.code == 'weak-password') {
        Utils.showErrorSnackbar(
            title: 'Senha muito fraca:',
            message: 'A senha informada precisa ter no minimo 6 caracteres.');
      } else if (e.code == 'invalid-email') {
        Utils.showErrorSnackbar(
            title: 'Email inválido:', message: 'O email informado é inválido.');
      } else {
        Utils.showErrorSnackbar(
            title: 'Erro no cadastro:',
            message: 'Ocorreu um problema, tente novamente mais tarde.');
      }
      return false;
    }
  }
}
