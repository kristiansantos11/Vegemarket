import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegemarket/Model/itemData.dart';

// Self item list getter
class VendorItemListGetter {
  final CollectionReference itemList = FirebaseFirestore.instance.collection('Basic Info');
  final String userUID;

  VendorItemListGetter(this.userUID);

  List<ItemData> item(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {

      return ItemData(
        itemName: doc['itemName'] ?? '',
        vendorUID: doc['vendorUID'] ?? '',
        description: doc['description'] ?? '',
        itemPictureLink: doc['itemPictureLink'] ?? '',
        username: doc['username'] ?? '',
      );
    }).toList();
  }
  Stream<List<ItemData>> get itemListData {
    return itemList.doc(userUID).collection("items").snapshots().map(item);
  }
}
