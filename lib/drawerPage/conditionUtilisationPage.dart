import 'package:flutter/material.dart';
import 'package:assouka_chef/ressources/Colors.dart';

class ConditionUtilisation extends StatelessWidget {
  const ConditionUtilisation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
            title: Text("Conditions d'utilisation", style: TextStyle(color: Colors.black),),
          backgroundColor: Couleurs.buttonPageRetaurantColors,
          //backgroundColor: Colors.lightGreenAccent,
          iconTheme: IconThemeData(
              color: Colors.black
          ),
        ),
        body: Container(
          color: Colors.black87,
        )
    );
  }
}
