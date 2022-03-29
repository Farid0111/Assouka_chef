import 'package:flutter/material.dart';
import 'package:assouka_chef/ressources/Colors.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("A propos", style: TextStyle(color: Colors.black),),
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
