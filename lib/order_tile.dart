import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(
      {Key? key,
      required this.product,
      required this.quantity,
      required this.timestamp,
      required this.id})
      : super(key: key);

  final String product, id;
  final DateTime timestamp;
  final num quantity;

  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Jumlah ${quantity}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  "Waktu Pembelian \n${timestamp}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              await FirebaseFirestore.instance
                  .collection('carts')
                  .doc(id)
                  .delete();
            },
            child: Icon(
              Icons.delete,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
