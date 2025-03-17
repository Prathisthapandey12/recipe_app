import 'package:flutter/material.dart';

class AppHomeScreen extends StatefulWidget{
  const AppHomeScreen({Key? key}) : super(key: key);

  @override
  State<AppHomeScreen> createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
    );
  }
}