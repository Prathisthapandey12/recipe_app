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
        backgroundColor:  const Color.fromARGB(255, 12, 96, 15),
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
        child : ListView.builder(
              itemCount: favoriteItems.length,
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
                    return Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(15),
                          child : Container(
                            width: double.infinity,
                            padding : EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child : Row(children: [
                              Container(
                                height : 80,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  image : DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(snapshot.data!['image'],
                                    ))
                                ),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data!['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Row(children: [
                                    Icon(Icons.flash_on, size : 16 ,color: Colors.grey,),
                                    Text("${snapshot.data!['cal']} Cal", style: TextStyle(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),),
                                    Text(" . ", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w900),),
                                    Icon(Icons.access_time, size : 16 ,color: Colors.grey,),
                                    Text("${snapshot.data!['time']} min", style: TextStyle(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),),
                                  ],)
                                ],
                              ),
                              SizedBox(width: 10,),
                              GestureDetector(
                                onTap: (){
                                  provider.toggleFavorite(snapshot.data!);
                                },
                                child: Icon(
                                  Icons.delete,
                                  size: 30,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                            )
                          )
                        )

                      ],
                    );
                  },
              );
              },
            ),

      )
    );
  }
}