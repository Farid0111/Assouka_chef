import 'package:assouka_chef/ressources/Colors.dart';
import 'package:flutter/material.dart';

class MaComptabilitePage extends StatefulWidget {
  const MaComptabilitePage({Key? key}) : super(key: key);

  @override
  _MaComptabilitePageState createState() => _MaComptabilitePageState();
}

class _MaComptabilitePageState extends State<MaComptabilitePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ma comptabilité", style: TextStyle(color: Colors.black),),
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
