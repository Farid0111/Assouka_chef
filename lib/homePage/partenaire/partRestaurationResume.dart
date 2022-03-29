

import 'package:assouka_chef/home.dart';
import 'package:assouka_chef/homePage/partenaire/creerCatalogue.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';


class PartRestaurationResume extends StatefulWidget {

  String? userName ;
  String nomResto, slogan, numeroTelephone, registreCommerce, typePartenariat ;
  PartRestaurationResume ({ required this.userName,  required this.nomResto, required  this.numeroTelephone, required  this.registreCommerce, required  this.slogan, required this.typePartenariat});

  @override
  _PartRestaurationResumeState createState() => _PartRestaurationResumeState();
}

class _PartRestaurationResumeState extends State<PartRestaurationResume> {

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

 //   print(this.widget.userName);

    return Scaffold(

      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(Chaines.partenariat, style: TextStyle(color: Couleurs.black),),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
                child: Container(
                  width: 150,
                  height: 150,
                  child: CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage("assets/images/Restaurant.jpeg"),
                  ),
                ),
              ),

              champSaisir (label:Chaines.type_resto_partenariat , values: this.widget.typePartenariat),
              champSaisir (label:Chaines.nom_resto , values: this.widget.nomResto),
              champSaisir (label:Chaines.slogan , values: this.widget.slogan),
              champSaisir (label:Chaines.numero_telephone , values: this.widget.numeroTelephone),
              champSaisir (label:Chaines.rcc , values: this.widget.registreCommerce),


        /*      Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width-100,
                  height: 60,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nom du restaurant',
                      labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width-100,
                  height: 60,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Slogan',
                      labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width-100,
                  height: 60,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Numéro de téléphone',
                      labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width-100,
                  height: 60,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Régistre de commerce',
                      labelStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      border: OutlineInputBorder(
                          borderRadius:
                          BorderRadius.circular(5)),
                    ),
                  ),
                ),
              ),*/



            /*  Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 50),
                    child: RaisedButton(
                      onPressed: () {
                        var route = MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Partenariat2());
                        Navigator.of(context).push(route);
                      },
                      color: Theme.of(context).accentColor,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                           30, 10, 20, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              Chaines.suivant,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),*/

              Align(
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height:  MediaQuery.of(context).size.height * 0.08,),
                    child: ElevatedButton.icon(

                      label: Text("Soumettre" /*Chaines.suivant*/, style: TextStyle(color: Couleurs.black),),
                      icon: Icon(Icons.check_circle_outline, color: Colors.black,),
                      onPressed: () {


                        // User Liste seach name
                        List <String> splitList = this.widget.nomResto.split(" ");
                        List <String> indexList = [];

                        for (int i = 0; i < splitList.length; i++)
                        {
                          for (int y = 1; y < splitList[i].length + 1; y++)
                          {
                            indexList.add(splitList[i].substring(0,y).toLowerCase());
                          }
                        }


                        setState(() {
                          isLoading = true;

                          addRestaurant_FireStore(


                            numero_telephone: this.widget.numeroTelephone,
                            name: this.widget.nomResto,
                            chefName: this.widget.userName,
                            activer: false,
                            cartegory: this.widget.typePartenariat,
                            context: context,
                          //  date_ajout: DateFormat( "dd - MMM - yyyy à HH:mm", Localizations.localeOf(context).languageCode).format(DateTime.now()).toString(),
                            date_ajout: (DateTime.now()).toString(),
                          //  description: this.widget.,
                            email: FirebaseAuth.instance.currentUser!.email,
                            like_counpteur: 0,
                            localisation: "",
                            prix: "",
                            registre_commerce: this.widget.registreCommerce,
                            searchResto: indexList,
                            slogant: this.widget.slogan,
                            userUID: FirebaseAuth.instance.currentUser!.uid,

                          );
                        });

                      //  Navigator.pop(context);
                      //  Navigator.pop(context);

                     //   Navigator.pop(context);
/*
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child:  HomePage()),
                            //  child:  CreerCatalogue()),
                          //    child:  Partenariat2()),
                        );

                        */

                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        primary: Couleurs.buttonPageRetaurantColors,
                      //  primary: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

   // Widget Champ de saisi
 Widget champSaisir ({required String label, required String values}) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(5),
       // width: MediaQuery.of(context).size.width-100,
       //  height: 60,
        width: MediaQuery.of(context).size.width * 0.8,
        height:  MediaQuery.of(context).size.height * 0.1,

        child: TextFormField(
          enabled: false,
          readOnly: true,
          initialValue: values,
          decoration: InputDecoration(
            focusColor: Colors.red,
            labelText: label,
            labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold),
            border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(10)),
          ),
        ),
      ),
    );
 }


// Add Event  to Cloud FireStore
  Future<void> addRestaurant_FireStore(
      {
        required BuildContext context,
        required String? userUID ,
       // required String? uid ,
        required String? name,
        required String? chefName,
        required String? slogant ,

        required String? numero_telephone ,
        required String? registre_commerce ,
        required int? like_counpteur ,

   //     required String? description ,
        required String? date_ajout ,
        required bool? activer ,

        required String? prix ,
        required String? cartegory ,
        required String? localisation ,

    //    required String? abonnement ,
        required List <String?> searchResto ,
        required String? email ,
      //  required int? timeStampe ,



      } ) async {

//  String eventDocID ;

    CollectionReference event = FirebaseFirestore.instance.collection(Chaines.restaurant_Collection);

    // Call the user's CollectionReference to add a new user
    var docRef = await event
        .add({

      'email': email,
      'name': name,
      'chefName': chefName,
    //  'abonnement': abonnement,

      'activer': false,
      'cartegory': cartegory,
      'date_ajout': date_ajout,
      'date_activation': "",

  //    'description': description,
      'like_counpteur': like_counpteur,
      'localisation': localisation,

      'prix': prix,
      'mobileNumber': numero_telephone,
      'RCCM': registre_commerce,

      'slogant': slogant,
      'uid': "uid",
      'userUID': userUID,
      'searchResto': searchResto,
      'timestamp': FieldValue.serverTimestamp()

    })
        .then((value) {


      String docID =   value.id;
      updateUser(docID, context);

    }

    )
    //   .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }


  CollectionReference eventID_docu = FirebaseFirestore.instance.collection(Chaines.restaurant_Collection) ;
  Future<void> updateUser(String doc, BuildContext context) {
    return eventID_docu
        .doc(doc)
        .update({'uid': doc})
        .then((value) {

      Fluttertoast.showToast(msg: "Restaurant créer",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15,
        toastLength: Toast.LENGTH_LONG,);

      Navigator.pop(context);
      Navigator.pop(context);

    })


       // .then((value) =>   Navigator.pop(context))
        .catchError((error) => print("Failed to update event: $error"));
  }



}
