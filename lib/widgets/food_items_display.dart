import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/Provider/favorite_provider.dart';
import 'package:recipe_app/views/app_recipe_screen.dart';

class FoodItemsDisplay extends StatefulWidget {

  final DocumentSnapshot<Object?> documentSnapshot;
  
  const FoodItemsDisplay({super.key, required this.documentSnapshot});

  @override
  State<FoodItemsDisplay> createState() => _FoodItemsDisplayState();
}

class _FoodItemsDisplayState extends State<FoodItemsDisplay> {

  @override
  Widget build(BuildContext context) {

    final provider = FavoriteProvider.of(context);
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AppRecipeScreen(documentSnapshot: widget.documentSnapshot)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width : 230,
        child : Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(widget.documentSnapshot['image']),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(widget.documentSnapshot['name'], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Row(children: [
              Icon(Icons.flash_on, size : 16 ,color: Colors.grey,),
              Text("${widget.documentSnapshot['cal']} Cal", style: TextStyle(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),),
              Text(" . ", style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w900),),
              Icon(Icons.access_time, size : 16 ,color: Colors.grey,),
              Text("${widget.documentSnapshot['time']} min", style: TextStyle(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),),
              
            ],)
            ],),

            // Add favorite button
            Positioned(
              top: 5,
              right: 5,
              child: CircleAvatar(
                radius: 18,
                backgroundColor: Colors.white,
                child: InkWell(
                  onTap: (){
                    provider.toggleFavorite(widget.documentSnapshot);
                  },
                  child: Icon(
                    provider.isExist(widget.documentSnapshot) ? Icons.favorite : Icons.favorite_border ,
                    color: provider.isExist(widget.documentSnapshot) ? Colors.red : Colors.black,
                    size: 20,
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}