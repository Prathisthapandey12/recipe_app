import 'package:flutter/material.dart';
import 'package:recipe_app/views/app_home_screen.dart';
import 'package:recipe_app/views/app_favorite_screen.dart';

class AppMainScreen extends StatefulWidget{
  const AppMainScreen({Key? key}) : super(key: key);

  @override
  State<AppMainScreen> createState() => _AppMainScreenState();
}

class _AppMainScreenState extends State<AppMainScreen>{

  int selectedindex = 0;
  late final List<Widget> page;

  @override
  void initState(){
    page = [
      AppHomeScreen(),
      AppFavoriteScreen(),
      navbarpage(Icons.restaurant_menu),
      navbarpage(Icons.settings),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 25,
        currentIndex: selectedindex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        onTap: (value){
          setState(() {
            selectedindex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon( selectedindex==0 ? Icons.home : Icons.home_outlined),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedindex==1 ? Icons.favorite : Icons.favorite_border),
            label: 'Favorites'
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedindex==2 ? Icons.restaurant_menu : Icons.restaurant_menu_outlined),
            label: 'Meal Plan'
          ),
          BottomNavigationBarItem(
            icon: Icon(selectedindex==3 ? Icons.settings : Icons.settings_outlined),
            label: 'Settings'
          ),
        ],
        
      ),
      body: page[selectedindex],
    );
  }

  navbarpage(iconName){
    return Center(
      child: Icon(
        iconName,
        size: 100,
        color: Colors.black,
      ),
    );
  }
}