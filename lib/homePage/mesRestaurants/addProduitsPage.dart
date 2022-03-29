

import 'package:assouka_chef/login/model/user_model.dart';
import 'package:assouka_chef/model/restaurant.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class AddProduit extends StatefulWidget {

   String? userName ;
   Restaurant? restoMain ;
   AddProduit({Key? key, this.restoMain, this.userName}) : super(key: key);

  @override
  State<AddProduit> createState() => _AddProduitState();
}

class _AddProduitState extends State<AddProduit> {

  late String _nom = "", _description = "", _prix = "", _type = "" , _photoproduit = "";

  var _formkey = GlobalKey<FormState>();
  String? selectedValue = Chaines.CONST_PRODUIT_METS;

  bool autoValidate = false;

  bool isLoading = false;


  List<DropdownMenuItem<String>> get dropdownItems{
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text(Chaines.CONST_PRODUIT_METS),value: Chaines.CONST_PRODUIT_METS),
      DropdownMenuItem(child: Text(Chaines.CONST_PRODUIT_BOISSON),value: Chaines.CONST_PRODUIT_BOISSON),

    ];
    return menuItems;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Ajouter un produit", style: TextStyle(color: Colors.black, fontSize: 15),),
        backgroundColor: Couleurs.buttonPageRetaurantColors,
        //backgroundColor: Colors.lightGreenAccent,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: Couleurs.buttonPageRetaurantColors,)) :
        ListView(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: MediaQuery.of(context).size.height / 2),
          // alignment: Alignment.center,
          children: [
            Form(
              key: _formkey,
              child: SingleChildScrollView(
                // scrollDirection: Axis.vertical,
                child: Column(

                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),

                    // Type produit
                    // Type resto art
                    Container(
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 2, bottom: 2),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height:  MediaQuery.of(context).size.height * 0.1,
                      child: DropdownButtonFormField(
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.transparent,
                          ),
                          validator: (value) => value == null ? "Selectionner le type de restaurant" : null,
                          dropdownColor: Couleurs.buttonPageRetaurantColors,
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: dropdownItems),
                    ),
                    SizedBox(
                      height: 20,
                    ),


                    // Nom produit
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (item) {
                        return item!.length > 0 ? null : "Le nom du produit";
                      },
                      onChanged: (item) {
                        setState(() {
                          _nom = item;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Le nom du produit",
                          labelText: "Le nom du produit",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Description
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      validator: (item) {
                        return item!.length < 08
                            ? "La description du produit est invalide"
                            : null;
                      },
                      onChanged: (item) {
                        setState(() {
                          _description = item;
                        });
                      },
                      /*   inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],*/
                      decoration: InputDecoration(
                          hintText: "La description du produit est invalide",
                          labelText: "La description du produit",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // Prix produit
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (item) {
                        return item!.length < 0
                            ? "Le prix du produit"
                            : null;
                      },
                      onChanged: (item) {
                        setState(() {
                          _prix = item;
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "Le prix du produit",
                          labelText: "Le prix du produit",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),



                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height *0.07,
                      child: RaisedButton(
                        color: Couleurs.buttonPageRetaurantColors,
                        onPressed: () {

                          addFirestore(resto: this.widget.restoMain);
                        },
                        child: Text(
                          "Enregister",
                        ),
                        textColor: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                  ],
                ),
              ),
            )
          ],
        ),

    );
  }


  void addFirestore({ Restaurant? resto}) {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        autoValidate = false;
      });

      // Add produit to resto
      addProduitDataToDb(resto:  resto);

    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }

  void addProduitDataToDb({ Restaurant? resto}) async {
    setState(() {
      isLoading = true;
    });


    // User Liste seach name
    List <String> splitList = _nom.split(" ");
    List <String> indexList = [];

    for (int i = 0; i < splitList.length; i++)
    {
      for (int y = 1; y < splitList[i].length + 1; y++)
      {
        indexList.add(splitList[i].substring(0,y).toLowerCase());
      }
    }

    CollectionReference proditCollection = FirebaseFirestore.instance.collection(Collections.collectionProduits);

    var docRef =  await proditCollection
        .add({

       'name': _nom,
      'chefName': this.widget.userName,
      'photo_produit': "URL PHOTO",

      'uidRestaurant': resto!.uid,
      'cartegory': resto.cartegory,
      'date_ajout': (DateTime.now()).toString(),


      'type': selectedValue,
      'description': _description,
      'like_counpteur': 0,


      'prix': _prix,
      'uid': "uid",
      'userUID': FirebaseAuth.instance.currentUser!.uid,

      'searchProduit': indexList,
      'timestamp': FieldValue.serverTimestamp()

    })
        .then((value) {


      String docID =   value.id;
      updateProduitUID(docID, context);

    }

    )
    //   .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add produit: $error"));

    setState(() {
      isLoading = false;

    });
  }

  CollectionReference produitID_docu = FirebaseFirestore.instance.collection(Collections.collectionProduits) ;
  Future<void> updateProduitUID(String doc, BuildContext context) {
    return produitID_docu
        .doc(doc)
        .update({'uid': doc})
        .then((value) {

      Fluttertoast.showToast(msg: "Produit créer",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15,
        toastLength: Toast.LENGTH_LONG,);

      Navigator.pop(context);

    })


    // .then((value) =>   Navigator.pop(context))
        .catchError((error) => print("Failed to update produit uid: $error"));
  }

}
