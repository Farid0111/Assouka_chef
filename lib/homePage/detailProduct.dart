
import 'package:assouka_chef/model/produit.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DetailProduct extends StatefulWidget {

  Produit? produit ;

  DetailProduct({this.produit});

  @override
  _DetailProductState createState() => _DetailProductState();
}
class _DetailProductState extends State<DetailProduct> {
  var nombrePlat = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
             /* Image.asset(
                'assets/images/food.jpeg',
              ),     */
              Container(
               /* width: 500,
                height: 1000,*/
                color: Colors.red,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/food.jpeg',
                      fit: BoxFit.fitHeight,
                      height: MediaQuery.of(context).size.height,
                      width: 500,

                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 10),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 40,
                            height: 40,
                            color: Colors.green,
                            child: Icon(Icons.arrow_back, color: Colors.white,size: 30,)),
                      ),
                    )
                  ],
                )
              ),
              Positioned(
                left: 0.0,
                right: 0.0,
                bottom: 0.0,
                child: Container(
                  height: MediaQuery.of(context).size.height/2,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18.0),
                        topRight: Radius.circular(18.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black45,
                            blurRadius: 16.0,
                            spreadRadius: 0.5,
                            offset: Offset(0.7, 0.7))
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 18.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.0),
                          Text(this.widget.produit!.name as String, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                          Text('Livraison à domicile',
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                           Visibility(
                             visible: false,
                             child: Row(
                               children: [
                                 IconButton(
                                     icon: Icon(Icons.add_box_rounded, color: Colors.green[200]),
                                     onPressed: () {
                                       setState(() {
                                        nombrePlat -= 1;
                                       });
                                     }),
                                    Text("$nombrePlat"),
                                 IconButton(
                                     icon: Icon(Icons.add_box_rounded, color: Colors.green),
                                     onPressed: () {
                                       setState(() {
                                         nombrePlat += 1;
                                       });
                                     }),
                               ],
                             ),
                           ),
                              Container(
                                  padding: EdgeInsets.all(15),
                                  color: Colors.green,
                                  child: Text( this.widget.produit!.prix! + " XOF", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),))
                            ],
                          ),

                          informationWiget(info:  this.widget.produit!.description!, titre: 'Description'),
                          informationWiget(info:  this.widget.produit!.date_ajout!, titre: 'Date à jour'),
                          informationWiget(info:  this.widget.produit!.cartegory!, titre: 'Cartegorie Resto'),


                          Visibility(
                            visible: false,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                  FlatButton(
                                    onPressed: () {
/*

                                      Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.rightToLeft,
                                            child:  PanierRestauExpress()),
                                      );
*/

                                     /* var route = MaterialPageRoute(
                                          builder: (BuildContext context) => PanierRestauExpress());
                                      Navigator.of(context).push(route);*/
                                    },
                                    child: Text(
                                      'Ajouter au panier',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                    color: Colors.green,
                                    minWidth: MediaQuery.of(context).size.width/1.15,
                                    height: 50,
                                  )
                                ]),
                              ),
                            ),
                          )
                        ],
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

   Widget informationWiget ({ required String titre , required String info})
    {
      return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       Text(titre, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
        Text(
          info, style: TextStyle( fontSize: 15),),

        SizedBox(
          height: 20.0,
        ),

    ],

      );
    }


}


