import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FoodItemsDisplay extends StatefulWidget {

  final DocumentSnapshot<Object?> documentSnapshot;

  const FoodItemsDisplay({super.key, required this.documentSnapshot});

  @override
  State<FoodItemsDisplay> createState() => _FoodItemsDisplayState();
}

class _FoodItemsDisplayState extends State<FoodItemsDisplay> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        width : 230,
        child : Stack(
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
            Text(widget.documentSnapshot['name'], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
            SizedBox(height: 5,),
            Row(children: [
              Icon(Icons.flash_auto, size : 16 ,color: Colors.grey,),
              Text("${widget.documentSnapshot['cal']} Cal", style: TextStyle(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),),
            ],)
          ],
        )
      ),
    );
  }
}