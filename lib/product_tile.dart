import 'package:flutter/material.dart';
import 'package:garasi_gitar/detail_product.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(
      {Key? key,
      required this.name,
      required this.harga,
      required this.ketagori,
      required this.deskripsi,
      required this.image,
      required this.id})
      : super(key: key);

  final String name, ketagori, deskripsi, image, id;
  final num harga;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(
              id: id,
              name: name,
              harga: harga,
              ketagori: ketagori,
              deskripsi: deskripsi,
              image: image,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 30,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
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
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Rp ${harga}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
