import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/widgets/food_items_display.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({super.key});

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {

  final CollectionReference foodItems = FirebaseFirestore.instance.collection('food-items');
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 198, 198),
        title: Text('All Recipes'),
        automaticallyImplyLeading: false ,
        elevation: 0,
        actions: [
          SizedBox(width: 10,),
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          Spacer(),
          Text('Recipes Easy to Prepare', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
          Spacer(),
          MyIconButton(icon: Icons.notifications, pressed: (){},),
          SizedBox(width: 10,),
        ],
      ),
      body : SingleChildScrollView(
        padding: EdgeInsets.only(left: 15, right: 5, top: 10),
        child : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
            SizedBox(height: 10,),
            StreamBuilder(
              stream: foodItems.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.hasData){
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      ),
                    itemBuilder: (context, index){

                      final DocumentSnapshot document = snapshot.data!.docs[index];
                      return Column(
                        children: [
                          FoodItemsDisplay(documentSnapshot: document),
                          Row(
                            children: [
                              Icon(Icons.star, size : 16 ,color: Colors.amberAccent,),
                              SizedBox(width: 5,),
                              Text("${document['rating']}", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                              Text("/5 ", style: TextStyle(fontSize: 12),),
                              Text("${document['reviews'].toString()} reviews", style: TextStyle(fontSize: 12, color: Colors.grey,fontWeight: FontWeight.bold),),
                            ],
                          )

                        ],
                      );
                      
                    }, itemCount: snapshot.data!.docs.length, shrinkWrap: true, physics: NeverScrollableScrollPhysics(), );
                }
                else{
                  return Center(child: CircularProgressIndicator());
                }
              },
              )
          ]
        )
      )
    );
  }
}