import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegemarket/Model/userData.dart';

class SellerListGetter
{
  final CollectionReference sellerList = FirebaseFirestore.instance.collection("Basic Info");

  List<UserData> seller(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      return UserData(
        uid : doc["uid"] ?? '',
        name : doc["name"] ?? '',
        username : doc["username"] ?? '',
        contactNumber : doc["contactNumber"] ?? '',
        profilePictureLink: doc["profile_picture"] ?? '',
        isSeller : doc["isSeller"] ?? '',
      );
    }).toList();
  }

  Stream<List<UserData>> get sellerListData {
    return sellerList.snapshots().map(seller);
  }
}