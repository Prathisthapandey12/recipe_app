import 'package:flutter/material.dart';

class QuantityProvider extends ChangeNotifier{

  int _currentNumber = 1;
  int get currentNumber => _currentNumber;

  List<double> _baseIngredientsAmounts = [];

  void setBaseIngredientsAmounts(List<double> amounts){
    
    _baseIngredientsAmounts = amounts;
    notifyListeners();
  }
  
  List<String> get updateIngredientsAmounts{
    return _baseIngredientsAmounts.map<String>( (amount) => (amount * _currentNumber).toStringAsFixed(1)).toList();
  }

  void increaseQuantity(){
    _currentNumber++;
    notifyListeners();
  }
  
  void decreaseQuantity(){

    if( _currentNumber > 1 ){
    _currentNumber--;
    notifyListeners();
    }
  }

}