import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegemarket/Model/itemData.dart';

// Self item list getter
class ItemListGetter {
  final CollectionReference itemList = FirebaseFirestore.instance.collection('Basic Info');
  final User user;

  ItemListGetter(this.user);

  List<ItemData> item(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ItemData(
        name: doc['name'] ?? '',
        vendorUID: doc['vendorUID'] ?? '',
        description: doc['description'] ?? '',
        itemPictureLink: doc['itemPictureLink'] ?? '',
        username: doc['username'] ?? '',
      );
    }).toList();
  }
  Stream<List<ItemData>> get itemListData {
    return itemList.doc(user.uid).collection("items").snapshots().map(item);
  }
}
