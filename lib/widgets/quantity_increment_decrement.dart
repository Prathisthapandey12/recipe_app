import 'package:flutter/material.dart';

class QuantityIncrementDecrement extends StatelessWidget {

  final int currentNumber;
  final Function() onAdd;
  final Function() onRemove;

  const QuantityIncrementDecrement({super.key, required this.currentNumber, required this.onAdd, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width:2.5, color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child : Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        IconButton(
          icon: Icon(Icons.remove),
          onPressed: (){
            onRemove();
          },
        ),
        SizedBox(width: 10,),
        Text(currentNumber.toString(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        SizedBox(width: 10,),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: (){
            onAdd();
          },
        ),
      ],)
    );
  }
}