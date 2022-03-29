import 'package:assouka_chef/model/panier.dart';
import 'package:assouka_chef/model/produit.dart';
import 'package:assouka_chef/model/restaurant.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../detailProductCommande.dart';

class Commande_encoursPage extends StatefulWidget {


  String? userNameChef ;
  Restaurant? resto ;
   Commande_encoursPage({Key? key, this.resto, this.userNameChef}) : super(key: key);

  @override
  _Commande_encoursPageState createState() => _Commande_encoursPageState();
}

class _Commande_encoursPageState extends State<Commande_encoursPage> {

  final Stream<QuerySnapshot> _lastEventStream = FirebaseFirestore.instance.collection(Collections.collectionPanier).orderBy("timeStampe_panier", descending: true).snapshots();



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

                          Produit produit =  Produit(
                            uid: data['produit_uid'],
                            userUID: data['produit_userUID'],
                            cartegory: data['produit_cartegory'],
                            name: data['produit_name'],
                            type: data['produit_type'],
                            prix: data['produit_prix'],
                            uidRestaurant: data['produit_userRestaurant'],
                            description: data['produit_description'],
                            nameChef: data['produit_nameChef'],
                            like_counpteur: data['produit_like_counpteur'],
                            date_ajout: data['produit_date_ajout'].toString(),

                          )  ;

                          Panier panier =  Panier(
                            quantity: data['quantity_panier'],
                            produit: produit,
                            date_ajout: data['produit_panier_date_ajout'],
                            statut_livrer: data['statut_livrer'],
                            statut_payer: data['statut_payer'] ,
                            // timeStampe: data['date_ajout'] ,
                            uid: data['produit_panier_uid'],
                            uid_cleint: data['panier_uid_client'],

                          )  ;

                          print("Type du produit ${produit.type}");
                          print("Cartegory du produit ${produit.cartegory}");
                          print("Produit chef current ${FirebaseAuth.instance.currentUser!.uid == produit.userUID}");

                          if(FirebaseAuth.instance.currentUser!.uid == produit.userUID
                             //  && produit.uidRestaurant == this.widget.resto!.uid
                              && panier.statut_livrer == false)

                            return


                              Card(
                                elevation: 10,
                                margin: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.0),topRight: Radius.circular(25.0), ),
                                ),
                                color: Colors.white,
                                // color: Colors.white70,
                                child: ListTile(

                                  onTap: (){
                                    setState(() {

                                      //   snapshot.data!.docs.length;



                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child:  DetailProductCommande(produit: produit,panier: panier,),
                                            inheritTheme: true,
                                            ctx: context),
                                      );



                                    });
                                  },

                                  leading: const Icon(Icons.restaurant/*, color: Colors.amber*/ , size: 30,),
                                  title: Text(data['produit_name'],style: TextStyle(fontWeight: FontWeight.w500)),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                          data['produit_prix'].toString() + " XOF"

                                      ),

                                      Text(
                                          " Qte : "+ data['quantity_panier'].toString()

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
                                     /*   Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: EditProduit(produit: produit,userName: widget.userNameChef,restoMain: widget.resto,),
                                              inheritTheme: true,
                                              ctx: context),
                                        );*/
                                        //   menu.show();

                                      });
                                    },
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


    );
  }
}
