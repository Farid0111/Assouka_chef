

import 'package:assouka_chef/login/model/user_model.dart';
import 'package:assouka_chef/model/produit.dart';
import 'package:assouka_chef/model/restaurant.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class EditProduit extends StatefulWidget {

   Produit? produit ;
   String? userName ;
   Restaurant? restoMain ;
   EditProduit({Key? key, this.restoMain, this.userName, this.produit}) : super(key: key);

  @override
  State<EditProduit> createState() => _EditProduitState();
}

class _EditProduitState extends State<EditProduit> {

  late String _nom = widget.produit!.name! , _description = widget.produit!.description!, _prix = widget.produit!.prix!, _type = "" , _photoproduit = "";

  var _formkey = GlobalKey<FormState>();
  String? selectedValue = Chaines.CONST_PRODUIT_METS;
  String? selectedValueMet = Chaines.CONST_PRODUIT_METS;
  String? selectedValueBoisson = Chaines.CONST_PRODUIT_BOISSON;

  bool autoValidate = false;

  bool isLoading = false;

  // CONTROLEUR




  List<DropdownMenuItem<String>> get dropdownItemsMet{
    List<DropdownMenuItem<String>> menuItemsMet = [
      DropdownMenuItem(child: Text(Chaines.CONST_PRODUIT_METS),value: Chaines.CONST_PRODUIT_METS),
      DropdownMenuItem(child: Text(Chaines.CONST_PRODUIT_BOISSON),value: Chaines.CONST_PRODUIT_BOISSON),

    ];
    return menuItemsMet;
  }

  List<DropdownMenuItem<String>> get dropdownItemsBoisson{
    List<DropdownMenuItem<String>> menuItemsBoison = [
      DropdownMenuItem(child: Text(Chaines.CONST_PRODUIT_BOISSON),value: Chaines.CONST_PRODUIT_BOISSON),
      DropdownMenuItem(child: Text(Chaines.CONST_PRODUIT_METS),value: Chaines.CONST_PRODUIT_METS),
    ];
    return menuItemsBoison;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Editer un produit", style: TextStyle(color: Colors.black, fontSize: 15),),
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
                          value: (widget.produit!.type == Chaines.CONST_PRODUIT_METS) ?  selectedValueMet : selectedValueBoisson,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                            });
                          },
                          items: (widget.produit!.type == Chaines.CONST_PRODUIT_METS) ? dropdownItemsMet : dropdownItemsBoisson)  ,
                    ),
                    SizedBox(
                      height: 20,
                    ),


                    // Nom produit
                    TextFormField(
                      initialValue: _nom,
                    //  controller: TextEditingController()..text = widget.produit!.name!,
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
                      initialValue: _description,
                   //   controller: TextEditingController()..text = widget.produit!.description!,
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
                      initialValue: _prix,
                    //  controller: TextEditingController()..text = widget.produit!.prix!,
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

                          addFirestore(resto: this.widget.restoMain, uiProduit: widget.produit!.uid as String);
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


  void addFirestore({ Restaurant? resto , required String uiProduit}) {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        autoValidate = false;
      });

      // Add produit to resto
      EditProduitDataToDb(resto:  resto,uiProduit: uiProduit);

    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }

  void EditProduitDataToDb({ Restaurant? resto, required String uiProduit}) async {
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
        .doc(uiProduit)
        .update({

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


      Fluttertoast.showToast(msg: "Produit modifier",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 15,
        toastLength: Toast.LENGTH_LONG,);

      Navigator.pop(context);

    }

    )
    //   .then((value) => print("User Added"))
        .catchError((error) => print("Failed to editt produit: $error"));

    setState(() {
      isLoading = false;

    });
  }


}
