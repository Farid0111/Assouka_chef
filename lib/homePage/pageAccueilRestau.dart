
import 'package:assouka_chef/Data/caroussel.dart';
import 'package:assouka_chef/homePage/detailProduct.dart';
import 'package:assouka_chef/model/produit.dart';
import 'package:assouka_chef/model/restaurant.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class PageAccueil extends StatefulWidget {

  Restaurant? resto ;
  PageAccueil ({this.resto});

  @override
  _PageAccueilState createState() => _PageAccueilState();
}


class _PageAccueilState extends State<PageAccueil> {


  @override
  void initState() {

    _listeOfProduit();

    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      /*  appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.black
          ),
      //    title: Text("", style: TextStyle(color: Couleurs.black),),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),*/

        body: SingleChildScrollView(
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                        //  color: Colors.green[100],
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width-MediaQuery.of(context).size.width/4,
                          height: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Recherche des mets',
                              labelStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(5)),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Couleurs.buttonPageRetaurantColors,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5.0),
                                //  topRight: Radius.circular(5.0),
                                //  bottomRight: Radius.circular( 5.0),
                                  bottomLeft: Radius.circular( 5.0)

                              )
                          ),

                        ),
                        Container(child: Icon(Icons.search),
                        width: 40, height: 50,// color: Colors.green[100],
                          decoration: BoxDecoration(
                              color: Couleurs.buttonPageRetaurantColors,
                              borderRadius: BorderRadius.only(
                                //  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                  bottomRight: Radius.circular( 5.0),
                                //  bottomLeft: Radius.circular( 5.0)

                              )
                          ),

                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Container(
                height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/4,
                  child: ListView(
             //     child: ListView(
                    children:[
                    ComplicatedImageDemo(),
                      Container(
                        height: 160,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Catégories de mets', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                ],
                              ),
                            ),
                            Container(
                              width:  MediaQuery.of(context).size.width,
                              height: 110,
                              child:  ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child:   Image.asset(
                                        'assets/images/Restaurant.jpeg',
                                      ),
                                    ),
                                  );
                                },
                              )
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),


                      Container(
                        height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.only(bottom: 50),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Mets les plus acheter', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                //    Text('voir tous', style: TextStyle(fontWeight: FontWeight.bold),)
                                  ],
                                ),
                              ),
                              Container(
                                width:  MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height/2.25,
                              //  height: MediaQuery.of(context).size.height/1.25,
                                child:  GridView.count(
                                  //            childAspectRatio: 3/2,
                                  scrollDirection: Axis.vertical,
                                  crossAxisCount: 2 ,
                                  children: List.generate( listeProduits.length,(index){
                                    return Container(
                                      child: GestureDetector(
                                        onTap: (){

                                      /*    Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                child:  DetailProduct()),
                                          );*/
                                        /*  var route = MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  DetailProduct());
                                          Navigator.of(context).push(route);*/


                                        },
                                        child: Card(
                                          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          ),
                                          elevation: 3.0,
                                          shadowColor: ( index  % 2 ==  0) ? Colors.green : Colors.green,
                                          color: Colors.white,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Center(
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height/10,
                                          //        height: MediaQuery.of(context).size.height/7,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.only (topLeft: Radius.circular(15.0), topRight: Radius.circular(45.0),),
                                                    image: DecorationImage(
                                                      image: AssetImage( 'assets/images/Restaurant.jpeg'),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.only( left: 2.0, right: 2.0),
                                                child: Text("500fcfa", style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 18,
                                                    fontStyle: FontStyle.normal
                                                ), textAlign: TextAlign.center,)
                                                ,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );

                                  }),
                                ),
                              ) ,
                            Text("Avis des clients", style: TextStyle(fontSize: 20),),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularPercentIndicator(
                                      radius: 60.0,
                                      lineWidth: 5.0,
                                      percent: 0.65,
                                      center: new Text("65%"),
                                      progressColor: Colors.green,
                                    ),
                                  ),   CircularPercentIndicator(
                                    radius: 60.0,
                                    lineWidth: 5.0,
                                    percent: 0.25,
                                    center: new Text("25%"),
                                    progressColor: Colors.orange,
                                  ),Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularPercentIndicator(
                                      radius: 60.0,
                                      lineWidth: 5.0,
                                      percent: 0.1,
                                      center: new Text("10%"),
                                      progressColor: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                  ],
                  )),
            ],
          ),
        ),


      ),
    );
  }


  //
  List<Produit> listeProduits = <Produit>[] ;
  // Get Liste complete of  Produit of current Resto
  void _listeOfProduit() {


    var firestore = FirebaseFirestore.instance;

    firestore.collection(Collections.collectionProduits).get().then((QuerySnapshot snapshot) {
    snapshot.docs.forEach((element)
      {


        Produit produit = new Produit(
          userUID: element["userUID"],
          uid: element["uid"],
          prix: element["prix"],
         // like_counpteur: element["TITRE"],
          description: element["description"],
          cartegory: element["cartegory"],
          nameChef: element["nameChef"],
          uidRestaurant: element["uidRestaurant"],
          type: element["type"],
          name: element["name"],
          date_ajout: element["date_ajout"],
         // photo_produit: element["TITRE"],

        );

        if(FirebaseAuth.instance.currentUser!.uid == produit.userUID  &&
          //  produit.cartegory == this.widget.resto!.cartegory &&
          //  produit.type.toString() == Chaines.CONST_PRODUIT_METS &&
        produit.uidRestaurant == this.widget.resto!.uid  )
        listeProduits.add(produit);


       // print (' ${ element["name"] } }');
        print (' ${ element["cartegory"] }');
      }

      );
    })/*.whenComplete(() =>  FIN_INITAILISATION_MUSIQUE = true)*/ ;


  }
}
