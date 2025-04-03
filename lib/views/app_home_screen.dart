import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';
import 'package:recipe_app/widgets/banner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/widgets/food_items_display.dart';
import 'package:recipe_app/views/view_all.dart';

class AppHomeScreen extends StatefulWidget{
  const AppHomeScreen({Key? key}) : super(key: key);

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen>{

  String category = 'All';
  // fetching the categories from the firestore
  final CollectionReference categoriesItems =
    FirebaseFirestore.instance.collection('categories');
  // fetching the recipes from the firestore
  Query get filteredRecipes => FirebaseFirestore.instance.collection('food-items').where('category', isEqualTo: category);
  Query get allRecipes => FirebaseFirestore.instance.collection('food-items');
  Query get selectedRecipes => category == 'All' ? allRecipes : filteredRecipes;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children : [
              SizedBox(height: 10,),
              Padding(
                padding : EdgeInsets.symmetric(horizontal: 20),
                child : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text('What are you \n cooking today?', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,height: 1,),),
                      const Spacer(),
                      MyIconButton(icon: Icons.notifications, pressed: (){},),

                    ],),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Container(
                        height : 40,
                        child : TextField(
                        style: TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search, size: 20,),
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
                      )
                    ),
                    BannerToExplore(),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20,),
                      child: Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,),),
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
                            setState(() {
                              category = streamSnapshot.data!.docs[index]['name'];
                            });
                          },
                          child : Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color : category == streamSnapshot.data!.docs[index]['name'] ? Color.fromARGB(255, 12, 96, 15)  : const Color.fromARGB(255, 238, 231, 231),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10,
                            ),
                            margin: const EdgeInsets.only(right : 20,
                            ),
                            child : Text(
                              streamSnapshot.data!.docs[index]['name'],
                              style: TextStyle(
                                color: category == streamSnapshot.data!.docs[index]['name'] ? Colors.white :  const Color.fromARGB(255, 107, 104, 104) ,
                                fontSize: 14, fontWeight: FontWeight.w600,
                              ),
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
              ),

              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Quick & Easy', style: TextStyle(fontSize: 14, letterSpacing: 0.1, fontWeight: FontWeight.bold, ),),
                ],
              ),
        ],
        )),
        SizedBox(height: 15,),
            StreamBuilder(
              stream: selectedRecipes.snapshots(),
              builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.hasData){
                final List<DocumentSnapshot> recipes = snapshot.data?.docs ?? [];
                return Padding(
                  padding: EdgeInsets.only(top : 5 , left : 15),
                  child : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child : Row(
                      children: recipes.map((e) =>
                        FoodItemsDisplay(documentSnapshot: e)).toList(),
                    )
                  )
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          )
      ],
    ),
    ),
    ),
    );
  }
}