import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/views/app_home_screen.dart';

class AppRecipeDirection extends StatefulWidget {

  final DocumentSnapshot<Object?> documentSnapshot;
  const AppRecipeDirection({super.key,required this.documentSnapshot});

  @override
  State<AppRecipeDirection> createState() => _AppRecipeDirectionState();
}

class _AppRecipeDirectionState extends State<AppRecipeDirection> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 200, 198, 198),
        title : Center(child: Text('Get directions'),),
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
          Text('Get Directions', style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),),
          Spacer(),
          SizedBox(width: 10,),
        ],
      ),
      body : SingleChildScrollView(
          child : Padding(
          padding: EdgeInsets.only(top: 10, left : 10),
          child : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 15,),
            Row(children: [
              Text( "Prep Time : " , style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), ),
              Icon(Icons.access_time, size : 32 ,color: Colors.grey,),
              Text( "${widget.documentSnapshot['time']} minutes" , style: TextStyle(fontSize: 18), )
            ],),
            SizedBox(height: 35,),
            Text('Ingredients',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,  // Center vertically
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.documentSnapshot['ingredientsimage'].map<Widget>(
                (imageurl) => Container(
                  height : 60,
                  width : 60,
                  margin : EdgeInsets.only(right : 10),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image : DecorationImage(
                  fit : BoxFit.cover,
                  image: NetworkImage(imageurl)
                ),
              ),
              )).toList(),
            ),
            SizedBox(height: 35,),
            Text('Procedure',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            SizedBox(height: 15,),
            Column(
            mainAxisAlignment: MainAxisAlignment.start,  // Center vertically
            crossAxisAlignment: CrossAxisAlignment.start,  // Align to the left
            children: widget.documentSnapshot['recipe'].asMap().entries.map<Widget>((entry) {
            int index = entry.key;
            String text = entry.value;
            return Padding(
            padding: const EdgeInsets.all(1),
            child: Text("${index + 1}. $text", style: TextStyle(fontSize: 14)),
            );
            }).toList(),
          ),

          SizedBox(height : 20),
          ElevatedButton(onPressed: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => AppHomeScreen() ),(Route<dynamic> route) => false, );
          }, child: Text('finished Cooking'))
          ],)
          )
      ),
    );
  }
}