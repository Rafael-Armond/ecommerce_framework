class ProductModel {
  String id = '';
  String name = '';
  String image = '';
  double price = 0;

  ProductModel(this.id, this.name, this.image, this.price);

  ProductModel.fromMap(dynamic data) {
    id = data['id'];
    image = data['image'];
    name = data['name'];
    price = double.tryParse(data['price']) ?? 0;
  }
}
