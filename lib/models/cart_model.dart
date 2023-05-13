import 'package:garasi_gitar/models/product_model.dart';

class CartModel {
  final int id;
  ProductModel product;
  late int quantity;  

  CartModel({
    required this.id,
    required this.product,
    required this.quantity,     
  });
}
