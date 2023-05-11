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

  factory ProductModel.fromSnapshot(QueryDocumentSnapshot<Object?> snapshot) {
    return ProductModel(
      id: snapshot.id,
      name: snapshot.get('name'),
      harga: snapshot.get('harga'),
      ketagori: snapshot.get('ketagori'),
      deskripsi: snapshot.get('deskripsi'),
      image: snapshot.get('image'),
      isFavorite: snapshot.get('isFavorite') ?? false,
    );
  }
}
