

import 'package:assouka_chef/homePage/partenaire/creerCatalogue.dart';
import 'package:assouka_chef/homePage/partenaire/partRestaurationResume.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class PartRestauration extends StatefulWidget {

  String? userNameChef ;
  PartRestauration({required this.userNameChef});

  @override
  _PartRestaurationState createState() => _PartRestaurationState();
}

class _PartRestaurationState extends State<PartRestauration> {


   String _dropDownValue = "";
 //  String? selectedValue = null;
   String? selectedValue = Chaines.CONST_EXPRESS;
   final _dropdownFormKey = GlobalKey<FormState>();

   late String _nomResto = "", _slogan  = "", _numeroTelephone = "", _registreCommerce = "", _typePartenariat = selectedValue! ;


   List<DropdownMenuItem<String>> get dropdownItems{
     List<DropdownMenuItem<String>> menuItems = [
       DropdownMenuItem(child: Text(Chaines.CONST_EXPRESS),value: Chaines.CONST_EXPRESS),
       DropdownMenuItem(child: Text(Chaines.CONST_NOSTAL),value: Chaines.CONST_NOSTAL),
       DropdownMenuItem(child: Text(Chaines.CONST_EVENT),value: Chaines.CONST_EVENT),
     ];
     return menuItems;
   }

  @override
  Widget build(BuildContext context) {



   // print(this.widget.userNameChef);

    return Scaffold(


      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(Chaines.partenariat, style: TextStyle(color: Couleurs.black),),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),

      body: Center(
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


           //   champSaisir (label:Chaines.nom_resto ),
           //   champSaisir (label:Chaines.slogan ),
          //    champSaisir (label:Chaines.numero_telephone ),
          //    champSaisir (label:Chaines.rcc ),


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

              Form(
                  key: _dropdownFormKey,
                  child: Container(
                    margin: const EdgeInsets.all(10.0),
                    child: Column(

                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        // Type resto art
                        Container(
                          padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
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
                        SizedBox(height: 10,),

                       // Nom resto
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height:  MediaQuery.of(context).size.height * 0.1,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (item) {
                              return item!.length > 0 ? null : Chaines.nom_resto;
                            },
                            onChanged: (item) {
                              setState(() {
                                _nomResto = item;
                              });
                            },

                            decoration: InputDecoration(
                                hintText: Chaines.nom_resto,
                                labelText: Chaines.nom_resto,
                              //  border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10))),


                          ),
                        ),
                        SizedBox(height: 10,),

                       // Slogan resto
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height:  MediaQuery.of(context).size.height * 0.1,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (item) {
                              return item!.length > 0 ? null : Chaines.slogan;
                            },
                            onChanged: (item) {
                              setState(() {
                                _slogan= item;
                              });
                            },

                            decoration: InputDecoration(
                                hintText: Chaines.slogan,
                                labelText: Chaines.slogan,
                              //  border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10))),


                          ),
                        ),
                        SizedBox(height: 10,),

                        // Numero Telephone resto
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height:  MediaQuery.of(context).size.height * 0.1,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                          //  maxLength: 14,

                            validator: (item) {
                              return item!.length < 08 ? Chaines.numero_telephone  : null ;
                            },
                            onChanged: (item) {
                              setState(() {
                                _numeroTelephone = item;
                              });
                            },

                            decoration: InputDecoration(
                                hintText: Chaines.numero_telephone,
                                labelText: Chaines.numero_telephone,
                              //  border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10))),


                          ),
                        ),
                        SizedBox(height: 10,),

                         // RCC resto
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height:  MediaQuery.of(context).size.height * 0.1,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            validator: (item) {
                              return item!.length > 0 ? null : Chaines.rcc;
                            },
                            onChanged: (item) {
                              setState(() {
                                _registreCommerce = item;
                              });
                            },

                            decoration: InputDecoration(
                                hintText: Chaines.rcc,
                                labelText: Chaines.rcc,
                              //  border: OutlineInputBorder(),
                                labelStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(10))),


                          ),
                        ),
                        SizedBox(height: 10,),


                    /*    ElevatedButton(
                            onPressed: () {
                              if (_dropdownFormKey.currentState!.validate()) {
                                //valid flow
                              }
                            },
                            child: Text("Submit"))*/
                      ],
                    ),
                  )),

              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                      width: MediaQuery.of(context).size.width * 0.5,
                      height:  MediaQuery.of(context).size.height * 0.08,),
                    child: ElevatedButton.icon(

                      label: Text( Chaines.suivant, style: TextStyle(color: Couleurs.black),),
                      icon: Icon(Icons.arrow_forward, color: Colors.black,),
                      onPressed: () {

                        if (_dropdownFormKey.currentState!.validate()) {

                          //valid flow
                          Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child:  PartRestaurationResume(
                                  userName : this.widget.userNameChef,
                                  registreCommerce: this._registreCommerce,
                                  typePartenariat: this.selectedValue as String,
                                  numeroTelephone: this._numeroTelephone,
                                  slogan: this._slogan,
                                  nomResto: this._nomResto,)),
                            //  child:  CreerCatalogue()),
                            //    child:  Partenariat2()),
                          );


                        }

                       /* Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child:  PartRestaurationResume()),
                            //  child:  CreerCatalogue()),
                          //    child:  Partenariat2()),
                        );*/
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
 Widget champSaisir ({required String label}) {
    return  Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: const EdgeInsets.all(5),
       // width: MediaQuery.of(context).size.width-100,
       //  height: 60,
        width: MediaQuery.of(context).size.width * 0.8,
        height:  MediaQuery.of(context).size.height * 0.1,

        child: TextFormField(
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

}
