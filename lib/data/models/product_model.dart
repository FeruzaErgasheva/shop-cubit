class ProductModel {
  String id;
  String name;
  double price;
  bool isFavourite;

  ProductModel({
    required this.id,
    this.isFavourite=false,
    required this.name,
    required this.price,
  });
}
