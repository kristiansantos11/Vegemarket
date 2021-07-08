import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegemarket/Model/userData.dart';

class SellerListSearchGetter
{
  final CollectionReference sellerList = FirebaseFirestore.instance.collection("Basic Info");
  final String userNameSearch;
  
  SellerListSearchGetter(this.userNameSearch);

  List<UserData> seller(QuerySnapshot snapshot)
  {
    return snapshot.docs.map((doc){
      return UserData(
        uid : doc["uid"] ?? '',
        name : doc["name"] ?? '',
        username : doc["username"] ?? '',
        contactNumber : doc["contactNumber"] ?? '',
        profilePictureLink: doc["profile_picture"] ?? '',
        houseStreetAddress: doc["houseStreetAddress"] ?? '',
        barangay: doc["barangay"] ?? '',
        city: doc["city"] ?? '',
        province: doc["province"] ?? '',
        isSeller : doc["isSeller"] ?? '',
      );
    }).toList();
  }

  Stream<List<UserData>> get sellerListSearchData {
    return sellerList.where("username", isEqualTo: userNameSearch).get().asStream().map(seller);
  }
}