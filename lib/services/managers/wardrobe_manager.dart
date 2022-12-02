import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:mokamayu/models/models.dart';
import '../authentication/auth.dart';
import '../database/database_service.dart';

class WardrobeManager extends ChangeNotifier {
  List<WardrobeItem> finalWardrobeItemList = [];
  Future<List<WardrobeItem>>? futureWardrobeItemList;

  Future<List<WardrobeItem>>? get getWardrobeItemList => futureWardrobeItemList;
  List<WardrobeItem> get getfinalWardrobeItemList => finalWardrobeItemList;

  void setWardrobeItem(Future<List<WardrobeItem>> itemList) {
    futureWardrobeItemList = itemList;
    //notifyListeners();
  }

  Future<List<WardrobeItem>> readWardrobeItemOnce() async {
    QuerySnapshot snapshot = await db
        .collection('users')
        .doc(AuthService().getCurrentUserID())
        .collection('wardrobe')
        .get();

    List<WardrobeItem> itemList = [];
    snapshot.docs.forEach((element) {
      WardrobeItem item = WardrobeItem.fromSnapshot(element);
      itemList.add(item);
    });
    finalWardrobeItemList = itemList;

    return finalWardrobeItemList;
  }

  void addWardrobeItem(WardrobeItem item) {
    db
        .collection('users')
        .doc(AuthService().getCurrentUserID())
        .collection('wardrobe')
        .add(item.toFirestore());
    notifyListeners();
  }
}
