
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class PageRestaurantEx extends StatefulWidget {
  @override
  _PageRestaurantExState createState() => _PageRestaurantExState();
}

class _PageRestaurantExState extends State<PageRestaurantEx> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage("assets/arr.png"),
          fit: BoxFit.cover,
          ),
          ),
        child: Scaffold(

          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(
                color: Colors.white
              //  color: Colors.black
            ),

            elevation: 0.0,
            backgroundColor: Colors.transparent,

          ),


          body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(

                    width: 150,
                    height: 150,

                    child: CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage("assets/images/Restaurant.jpeg"),
                    ),
                  ),
                ),

                // Resto express
                restaurantButton(indix: 1, nameRestaurant: Chaines.resto_express),
               /* Padding(
                  padding: const EdgeInsets.all(20.0),
                      child:   FlatButton(

                        onPressed: (){

                        var route = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PageRestoEx());
                        Navigator.of(context).push(route);
                      },
                        child: Text(Chaines.resto_express),
                        color: Couleurs.buttonPageRetaurantColors,
                     //   color: Colors.green[300],
                        minWidth: 250,height: 57,

                      ),
                    ),*/


                // Resto nostal
                restaurantButton(indix: 2, nameRestaurant: Chaines.resto_nostal),
               /* Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:   FlatButton(onPressed: (){
                    var route = MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AccueilNostal());
                    Navigator.of(context).push(route);
                  }, child: Text(Chaines.resto_nostal),
                    color: Couleurs.buttonPageRetaurantColors,
                  //  color: Colors.green[300],
                    minWidth: 250,height: 57,),
                ),*/

                // Resto Event
                restaurantButton(indix: 3, nameRestaurant: Chaines.resto_evenementiel),
               /* Padding(
                  padding: const EdgeInsets.all(20.0),
                  child:   FlatButton(onPressed: (){
                    var route = MaterialPageRoute(
                        builder: (BuildContext context) =>
                            AccueilEvennementiel());
                    Navigator.of(context).push(route);
                  }, child: Text(Chaines.resto_evenementiel),
                    color:  Couleurs.buttonPageRetaurantColors,
                  //  color: Colors.green[300],
                    minWidth: 250,height: 57,),
                ),*/



              ],
            ),
          )
          )
        ),
      ),
    );
  }


  // Widget Retaurant Button
  Widget restaurantButton ({required int indix, required String nameRestaurant}){

    return   Padding(
      padding: const EdgeInsets.all(20.0),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(
            width: MediaQuery.of(context).size.width * 0.6,
            height:  MediaQuery.of(context).size.height * 0.08,),

        child: ElevatedButton(

          onPressed: (){
/*
          // Restaurant Express
          if (indix == 1)
            {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child:  PageRestoEx()),
              );
            }

          // Restaurant Nostal
          else if (indix == 2)
            {
              Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child:  AccueilNostal()),
              );
            }

          // Restaurant Event
          else {
            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child:  AccueilEvennementiel()),
            );
          }

*/

         },

          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
              // <-- Radius
            ),
            primary: Couleurs.buttonPageRetaurantColors,



          ),


          child: Text(nameRestaurant, style: TextStyle(color: Colors.black),),
         // color:  Couleurs.buttonPageRetaurantColors,
          //  color: Colors.green[300],
         //   minWidth: MediaQuery.of(context).size.width * 0.6,
        //    height: MediaQuery.of(context).size.height * 0.08,

        ),
      ),
    );
  }


}
