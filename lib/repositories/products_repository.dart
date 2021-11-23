import 'package:flutter_firebase_ecommerce/views/shared/util/util.dart';
import 'package:flutter_firebase_ecommerce/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'interfaces/i_products_repository.dart';

class ProductsRepository implements IProductsRepository {
  @override
  Future<List<ProductModel>> getAllProducts() async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('products');
      QuerySnapshot querySnapshot = await collectionRef.get();
      final allProducts = querySnapshot.docs
          .map((doc) => ProductModel.fromMap(doc.data()))
          .toList();
      return allProducts;
    } catch (e) {
      Utils.showErrorSnackbar(
          title: 'Erro na obtenção dos produtos:',
          message:
              'Ocorreu um erro na obtenção dos produtos. Tente novamente mais tarde.');
      return [];
    }
  }
}
