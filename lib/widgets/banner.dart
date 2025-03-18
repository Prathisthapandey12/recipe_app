import 'package:flutter/material.dart';

class BannerToExplore extends StatelessWidget {
  const BannerToExplore({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(255, 12, 96, 15),
      ),
      child: Stack(
        children : [
          Positioned(
            top : 32,
            left : 20,
            child : Column(children: [
              Text('Explore new recipes \n and cook for yourself', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white, height : 1.1),),
              SizedBox(height: 10,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 33),
                  backgroundColor: Colors.white,
                  elevation: 0,
                ),
                onPressed: (){},
                child: Text("Explore",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold, color : Colors.black,),)
              ),
          ],)
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: -30,
            child: Image.asset('assets/images/cheff.png'),
          ),

        ],
      ),
    );
  }
}