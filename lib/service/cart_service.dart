import 'package:cloud_firestore/cloud_firestore.dart';

class Keranjang {
  String idUser;
  int kuantitas;
  String idProduct;

  Keranjang(
    this.idUser,
    this.idProduct,
    this.kuantitas,
  );
}

Future createKeranjang({
  required name,
  required harga,
}) async {
  final docUser = FirebaseFirestore.instance.collection('cart');

  final json = {'name': name, 'harga': harga};

  await docUser.add(json);
}

Future editKeranjang() async {
  FirebaseFirestore.instance
      .collection('cart')
      .doc('0WSNTY3PjrNeWuSDl8Eh')
      .update({'id': 'Some new data'});
}
