import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/my_icon_button.dart';
import 'package:recipe_app/widgets/banner.dart';
class AppHomeScreen extends StatefulWidget{
  const AppHomeScreen({Key? key}) : super(key: key);

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen>{

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
                ],)
              ),
              
          ]
        ),
      ),
      ),
    );
  }
}