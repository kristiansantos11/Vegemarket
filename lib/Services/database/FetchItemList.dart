import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vegemarket/Model/itemData.dart';

class ItemListGetter {
  final CollectionReference itemList = FirebaseFirestore.instance.collection('Basic Info');
  final String ignoreItemName;

  ItemListGetter(this.ignoreItemName);

  List<ItemData> item(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ItemData(
        name: doc['name'],
        description: doc['description'],
        comment: doc['comment'],
        rating: doc['rating'],
        itemPictureLink: doc['itemPictureLink'],
        //username: doc['username'],
      );
    }).toList();
  }
  Stream<List<ItemData>> get itemListData {
    return itemList.where('uid', isNotEqualTo: ignoreItemName).snapshots().map(item);
  }
}
