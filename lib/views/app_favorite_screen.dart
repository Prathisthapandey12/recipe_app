import 'package:flutter/material.dart';
import 'package:recipe_app/Provider/favorite_provider.dart';
import 'package:recipe_app/widgets/food_items_display.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppFavoriteScreen extends StatefulWidget {
  const AppFavoriteScreen({super.key});

  @override
  State<AppFavoriteScreen> createState() => _AppFavoriteScreenState();
}

class _AppFavoriteScreenState extends State<AppFavoriteScreen> {

  @override
  Widget build(BuildContext context) {
    final provider = FavoriteProvider.of(context);
    final favoriteItems = provider.favorites;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 198, 198),
        centerTitle: true,
        title: Text('Favorites', style: TextStyle(fontWeight: FontWeight.bold),),
        automaticallyImplyLeading: false ,
        elevation: 0,
      ),

      body : favoriteItems.isEmpty ?
      Center(
        child : Text('No favorites yet', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      )
      :
      Padding(
        padding: EdgeInsets.only(top: 10, left : 10),
        child : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 0.7,
                ),
              itemBuilder: (context, index){
                return FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance.collection('food-items').doc(favoriteItems[index]).get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Center(child: CircularProgressIndicator(),);
                    }
                    if( !snapshot.hasData || snapshot.data == null){
                      return Center(child: Text('Error loading favorites'),);
                    }
                    return FoodItemsDisplay(documentSnapshot: snapshot.data!);
                  },
              );
              },
              itemCount: favoriteItems.length,
            ),

      )
    );
  }
}