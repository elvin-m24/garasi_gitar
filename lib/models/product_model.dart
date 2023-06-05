import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String id;
  final String name;
  final num harga;
  final String ketagori;
  final String deskripsi;
  final String image;
  bool isFavorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.harga,
    required this.ketagori,
    required this.deskripsi,
    required this.image,
    this.isFavorite = false,
  });
  
}
