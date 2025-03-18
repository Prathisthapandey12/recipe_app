import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';
import 'package:recipe_app/widgets/banner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppHomeScreen extends StatefulWidget{
  const AppHomeScreen({Key? key}) : super(key: key);

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen>{

  String category = 'All';
  final CollectionReference categoriesItems = FirebaseFirestore.instance.collection('categories');

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
              Padding(
                padding : EdgeInsets.symmetric(horizontal: 20),
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text('What are you \n cooking today?', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold,height: 1,),),
                      const Spacer(),
                      MyIconButton(icon: Icons.notifications, pressed: (){},),

                    ],),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 22),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: InputBorder.none,
                          hintText : 'Search any recipe',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    BannerToExplore(),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20,),
                      child: Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
                    ),
                ],)
              ),

              StreamBuilder(
                stream: categoriesItems.snapshots() ,
                builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
                  if(streamSnapshot.hasData){
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(streamSnapshot.data!.docs.length, (index) => GestureDetector(
                          onTap :(){
                          },
                          child : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10,
                            ),
                            margin: const EdgeInsets.only(right : 20,
                            ),
                            child : Text(
                              streamSnapshot.data!.docs[index]['name'],
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          )
                        )),
                      ),
                    );

                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
                )
              
          ]
        ),
      ),
      ),
    );
  }
}