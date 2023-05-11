import 'package:flutter/material.dart';
import 'package:garasi_gitar/models/product_model.dart';
import 'package:garasi_gitar/provider/whislist_provider.dart';
import 'package:provider/provider.dart';

class WhislistCard extends StatelessWidget {
  const WhislistCard({
    Key? key,
    required this.name,
    required this.harga,
    required this.ketagori,
    required this.deskripsi,
    required this.image,
    required this.id,
    required this.product,
  }) : super(key: key);

  final String name, ketagori, deskripsi, image, id;
  final num harga;
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    WishlistProvider wishlistProvider = Provider.of<WishlistProvider>(context);

    ProductModel product = ProductModel(
      id: id,
      name: name,
      ketagori: ketagori,
      deskripsi: deskripsi,
      harga: harga,
      image: image,
    );

    return Container(
      margin: EdgeInsets.only(
        top: 20,
      ),
      padding: EdgeInsets.only(
        top: 10,
        left: 12,
        bottom: 14,
        right: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              image,
              width: 60,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Rp ${harga}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              wishlistProvider.setProduct(product);
            },
            child: Icon(
              Icons.favorite,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
