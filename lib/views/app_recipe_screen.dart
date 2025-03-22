import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/Provider/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Provider/quantity.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';
import 'package:recipe_app/widgets/quantity_increment_decrement.dart';

class AppRecipeScreen extends StatefulWidget {

  final DocumentSnapshot<Object?> documentSnapshot;
  const AppRecipeScreen({super.key, required this.documentSnapshot});

  @override
  State<AppRecipeScreen> createState() => _AppRecipeScreenState();
}

class _AppRecipeScreenState extends State<AppRecipeScreen> {
  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<FavoriteProvider>(context);
    final quantityProvider = Provider.of<QuantityProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: (){},
        label: Row(children: [
          ElevatedButton(
            onPressed: (){
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 13),
            foregroundColor: Colors.white,
            ),
            child: Text('Start cooking', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),),
          ),
          SizedBox(width: 10,),
          IconButton(
            style: IconButton.styleFrom(
              shape: CircleBorder(side: BorderSide(color: Colors.grey.shade300,width: 2,)),
            ),
            onPressed: (){
              provider.toggleFavorite(widget.documentSnapshot);
},
            icon: Icon(
            provider.isExist(widget.documentSnapshot) ? Icons.favorite : Icons.favorite_border ,
            color : provider.isExist(widget.documentSnapshot) ? Colors.red :  Colors.black,
            size : 22,)
          )
        ],)
      ),

      body : SingleChildScrollView(

        child : Column(
          children: [
            Stack(
              children : [
                Container(
                  height:   MediaQuery.of(context).size.height/2.1,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.documentSnapshot['image']),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  right : 10,
                  child: Row(
                    children: [
                      MyIconButton(
                        icon : Icons.arrow_back_ios_new,
                        pressed: (){
                          Navigator.pop(context);
                        }),
                      Spacer(),
                      MyIconButton(
                        icon: Icons.notifications,
                        pressed: (){

                        },
                        )
                      
                    ],),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top : MediaQuery.of(context).size.height/2.2,
                  child: Container(
                    width : double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
              ]
            ),
            Center(
              child : Container(
                width : 40,
                height : 8,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              )
            ),
            SizedBox(height: 20,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(widget.documentSnapshot['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.star, size : 16 ,color: Colors.amberAccent,),
                    SizedBox(width: 5,),
                    Text("${widget.documentSnapshot['rating']}", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                    Text("/5 ", style: TextStyle(fontSize: 12),),
                    Text("${widget.documentSnapshot['reviews'].toString()} reviews", style: TextStyle(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),),
                ],),
                SizedBox(height: 20,),
                Row(
                  children:[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ingredients', style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(height: 10,),
                      Text('How many servings ?', style: TextStyle(fontSize: 14,),),
                    ],
                  ),
                  Spacer(),
                  QuantityIncrementDecrement(
                    currentNumber: quantityProvider.currentNumber,
                    onAdd:() => quantityProvider.increaseQuantity(),
                    onRemove:() => quantityProvider.decreaseQuantity()
                  ),
                ],)
              ],),
            ),
        ],)
      )
    );
  }
}