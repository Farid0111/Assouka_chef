import 'package:assouka_chef/ressources/Colors.dart';
import 'package:flutter/material.dart';

class MesRetairesPage extends StatelessWidget {
  const MesRetairesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("Mes retraires", style: TextStyle(color: Colors.black),),
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
