

import 'package:assouka_chef/homePage/mesRestaurants/edithProduitsPage.dart';
import 'package:assouka_chef/model/produit.dart';
import 'package:assouka_chef/model/restaurant.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import '../../detailProduct.dart';
import '../addProduitsPage.dart';

class MetsHomePage extends StatefulWidget {

  String? userNameChef ;
  Restaurant? resto ;
  MetsHomePage({Key? key, this.resto, this.userNameChef}) : super(key: key);

  @override
  State<MetsHomePage> createState() => _MetsHomePageState();
}

class _MetsHomePageState extends State<MetsHomePage> {

  final Stream<QuerySnapshot> _lastEventStream = FirebaseFirestore.instance.collection(Collections.collectionProduits).orderBy("timestamp", descending: true).limit(30).snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Container(
          //    color: Colors.black87,
          child: SingleChildScrollView(
            child: Column(
              children: [


                StreamBuilder<QuerySnapshot>(
                    stream: _lastEventStream,
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if(snapshot.hasData)
                      {

                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                            Produit produit = new Produit(

                              userUID: data['userUID'],
                              uid: data['uid'],
                              cartegory: data['cartegory'],
                              type: data['type'],
                              name: data['name'],
                              prix: data['prix'],
                              uidRestaurant: data['uidRestaurant'],
                              description: data['description'],
                              nameChef: data['chefName'],
                              like_counpteur: data['like_counpteur'],
                              date_ajout: data['date_ajout'].toString(),

                            )  ;


                            if(FirebaseAuth.instance.currentUser!.uid == produit.userUID  &&
                              //  produit.cartegory == this.widget.resto!.cartegory &&
                                produit.type.toString() == Chaines.CONST_PRODUIT_METS && produit.uidRestaurant == this.widget.resto!.uid)

                              return


                                GestureDetector(
                                  onLongPress: (){
                                    deleteProduit(uidProduitPanier: produit.uid as String);
                                  },
                                  child: Card(
                                    elevation: 10,
                                    margin: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.0),topRight: Radius.circular(25.0), ),
                                    ),
                                   // color: Colors.white,
                                     color: Colors.white
                                    ,
                                    child: ListTile(

                                      onTap: (){
                                        setState(() {

                                          //   snapshot.data!.docs.length;


                                          Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.rightToLeft,
                                                child:  DetailProduct(produit: produit,),
                                                inheritTheme: true,
                                                ctx: context),
                                          );


                                        });
                                      },

                                      leading: const Icon(Icons.restaurant/*, color: Colors.amber*/ , size: 30,),
                                    title: Text(data['name'],style: TextStyle(fontWeight: FontWeight.w500)),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Text(
                                              data['prix'].toString() + " XOF"

                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          //Icons.more_vert,
                                          color: Colors.black, size: 18,),
                                        onPressed: ()  {
                                          setState(() {
                                            print("HH");
                                            print("${produit.name}");
                                           Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.rightToLeft,
                                                  child: EditProduit(produit: produit,userName: widget.userNameChef,restoMain: widget.resto,),
                                                  inheritTheme: true,
                                                  ctx: context),
                                            );
                                            //   menu.show();

                                          });
                                        },
                                      ),


                                    ),
                                  ),
                                );

                            else
                              return Container();
                          }).toList(),
                        );




                      }

                      return  Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(top:  10.0),
                          child: CupertinoActivityIndicator(
                            animating: true,
                            radius: MediaQuery.of(context).size.width *0.08,
                          ),
                        ),
                      );
                    }
                ),

              ],
            ),
          ),
        ),



        floatingActionButton: FloatingActionButton(
          onPressed: () {

            Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child:  AddProduit(restoMain: this.widget.resto, userName: this.widget.userNameChef,),
                  inheritTheme: true,
                  ctx: context),
            );
          },
            backgroundColor: Couleurs.buttonPageRetaurantColors,
           child: const Icon(Icons.add, color: Colors.black,),
    ),);
  }


  void deleteProduit ({required String uidProduitPanier})
  {
    FirebaseFirestore.instance.collection(Collections.collectionProduits)
        .doc(uidProduitPanier)
        .delete()
        .then((value) {


      Fluttertoast.showToast(msg: "Mets supprimer",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15,
        toastLength: Toast.LENGTH_LONG,);

      print("Produit delete form cart");
    })
        .catchError((error) => print("Failed to delete produit: $error"));
  }
}
