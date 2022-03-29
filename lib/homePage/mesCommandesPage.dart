import 'package:assouka_chef/homePage/commandes/commande_en_cours.dart';
import 'package:assouka_chef/homePage/commandes/commande_livrer.dart';
import 'package:assouka_chef/model/restaurant.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:flutter/material.dart';


class MesCommandesPage extends StatelessWidget {

  String? userNameChef ;
  Restaurant? resto ;
   MesCommandesPage({Key? key, this.resto, this.userNameChef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,

              tabs: [
                Tab(text: "En cours",icon: Icon(Icons.shopping_cart)),
                Tab(text: "Terminer",icon: Icon(Icons.agriculture_outlined)),
              ],
            ),
            title: const Text('Mes commandes', style: TextStyle(color: Colors.black),),
            backgroundColor: Couleurs.buttonPageRetaurantColors,
            centerTitle: true,
            iconTheme: IconThemeData(
                color: Colors.black
            ),
          ),
          body:  TabBarView(
            children: [

              Commande_encoursPage(/*resto: , userNameChef: ,*/),
              Commande_livrerPage(/*resto: , userNameChef: ,*/),
             // Icon(Icons.shopping_cart),
             // Icon(Icons.agriculture_outlined),

            ],
          ),
        ),
      ),
    );
  }
}