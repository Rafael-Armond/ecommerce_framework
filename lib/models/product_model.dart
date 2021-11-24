class ProductModel {
  late String id;
  late String name;
  late String image;
  late double price;

  ProductModel(this.id, this.name, this.image, this.price);

  ProductModel.fromMap(dynamic data) {
    id = data['id'];
    image = data['image'];
    name = data['name'];
    price = double.tryParse(data['price']) ?? 0;
  }
}
