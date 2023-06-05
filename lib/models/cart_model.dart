import 'package:garasi_gitar/models/product_model.dart';

class CartModel {
  final int id;
  final String userid;
  ProductModel product;
  late num totalprice;
  late int quantity;

  CartModel({
    required this.id,
    required this.userid,
    required this.product,
    required this.totalprice,
    required this.quantity,
  });
}
