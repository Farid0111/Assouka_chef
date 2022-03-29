import 'package:assouka_chef/model/restaurant.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../pageAccueilRestau.dart';
import 'accueilResto/accueil.dart';
import 'boissonResto/boisson.dart';
import 'metsResto/mets.dart';


class MesRestaurantHomePrincipalPage extends StatefulWidget {

  String? userNameChef ;
  Restaurant? resto ;
  MesRestaurantHomePrincipalPage({Key? key,this.resto, this.userNameChef}) : super(key: key);

  @override
  State<MesRestaurantHomePrincipalPage> createState() => _MesRestaurantHomePrincipalPageState();
}

class _MesRestaurantHomePrincipalPageState extends State<MesRestaurantHomePrincipalPage> {


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 10),

              tabs: [
                Tab(text: "Accueil",icon: Icon(Icons.home_outlined),),
                Tab(text: "Mes mets",icon: Icon(Icons.food_bank_outlined)),
                Tab(text: "Mes boissons/Cocktail",icon: Icon(Icons.wine_bar_rounded),),
              ],
            ),
            title:  Text('${this.widget.resto!.name as String}',  style: GoogleFonts.acme(
              textStyle: TextStyle(color: Colors.black, letterSpacing: .5),
            ),),
            backgroundColor: Couleurs.buttonPageRetaurantColors,
            centerTitle: true,
            iconTheme: IconThemeData(
                color: Colors.black
            ),
          ),
          body:  TabBarView(
            children: [
              AccueilHome(resto:  this.widget.resto,),
            //  PageAccueil(),
              MetsHomePage( userNameChef: this.widget.userNameChef, resto: this.widget.resto,),
              BoissonHomePage( userNameChef: this.widget.userNameChef, resto: this.widget.resto,),

            ],
          ),
        ),
      ),
    );
  }
}