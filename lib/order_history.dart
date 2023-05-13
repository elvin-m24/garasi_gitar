import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:garasi_gitar/order_tile.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference product = firestore.collection("carts");

    PreferredSizeWidget header() {
      return AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Order History',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget order() {
      return Container(
        margin: EdgeInsets.only(
          top: 14,
        ),
        child: StreamBuilder<QuerySnapshot>(
            stream: product.snapshots(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: snapshot.data!.docs
                          .map(
                            (e) => OrderTile(
                              id: e.id,
                              product: e.get("product"),
                              quantity: e.get("quantity"),
                              timestamp: e.get("timestamp").toDate(),
                            ),
                          )
                          .toList())
                  : Container();
            }),
      );
    }

    return Scaffold(
      appBar: header(),
      body: order(),
    );
  }
}
