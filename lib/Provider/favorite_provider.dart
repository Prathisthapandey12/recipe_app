import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProvider extends ChangeNotifier{
  List<String> _favoriteIds = [];

  // getter (get function) to get the favorite list
  List<String> get favorites => _favoriteIds;

  FavoriteProvider(){
    loadFavorites();
  }

  void toggleFavorite(DocumentSnapshot product) async{
    String productId = product.id;
    if(_favoriteIds.contains(productId)){
      _favoriteIds.remove(productId); // remove from the list
      await _removefavorite(productId); // remove from favorite
    }else{
      _favoriteIds.add(productId); // add to the list
      await _addfavorite(productId); // add to favorite
    }
    notifyListeners();
  }

  bool isExist(DocumentSnapshot product){
    String productId = product.id;
    return _favoriteIds.contains(productId);
  }

  Future<void> _addfavorite(String productId) async{
    // add to favorite to firestore
    try{
      await FirebaseFirestore.instance.collection('favorites').doc(productId).set({
        'isFavorite' : true,
      });
    }catch(e){
      print(e);
    }
  }

  Future<void> _removefavorite(String productId) async{
    // remove from favorite to firestore
    try{
      await FirebaseFirestore.instance.collection('favorites').doc(productId).delete();
    }catch(e){
      print(e);
    }
  }

  Future<void> loadFavorites() async{
    try{
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('favorites').get();
      _favoriteIds = snapshot.docs.map((e) => e.id).toList();
    }catch(e){
      print(e);
    }
    notifyListeners();
  }

  // static method to get the provider from any context
  static FavoriteProvider of(BuildContext context, {bool listen = true} ){
    return Provider.of<FavoriteProvider>(context, listen: listen);
  }
}