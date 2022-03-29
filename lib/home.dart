


import 'dart:io';




import 'package:assouka_chef/drawerPage/aboutPage.dart';
import 'package:assouka_chef/drawerPage/conditionUtilisationPage.dart';
import 'package:assouka_chef/drawerPage/contactPage.dart';
import 'package:assouka_chef/drawerPage/politiquePage.dart';
import 'package:assouka_chef/drawerPage/profilPage.dart';
import 'package:assouka_chef/homePage/maComptabilitePage.dart';
import 'package:assouka_chef/homePage/mesCommandesPage.dart';
import 'package:assouka_chef/homePage/mesRestaurantsPage.dart';
import 'package:assouka_chef/homePage/mesretairesPage.dart';
import 'package:assouka_chef/homePage/partenaire/partRestauration.dart';
import 'package:assouka_chef/login/auth/login_screen.dart';
import 'package:assouka_chef/model/modelHomeScreenCartg.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';




class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  /*
  FirebaseAuth _auth = FirebaseAuth.instance;
  User _user;
  FacebookLogin facebookLogin = FacebookLogin();
   */

  String? userName = FirebaseAuth.instance.currentUser!.displayName ;


  // Package Info
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Iconnue',
    packageName: 'Iconnue',
    version: 'Iconnue',
    buildNumber: 'Iconnu',
  );

  List<ModelCartegory> listmodels = <ModelCartegory>[];




  @override
  void initState() {
    // TODO: implement initState


    getUsername();
    super.initState();
    listmodels = getCartegoris();
    _initPackageInfo();


  }


  int _selected = 0;
  void changeSelected (int index )
  {
    setState(() {
      _selected = index ;
    });
  }


  getUsername() async{
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Collections.collectionUserChef).doc(FirebaseAuth.instance.currentUser!.uid).get();
    setState(() {
      userName = ds.get(Chaines.user_full_name);
    });

  }

  void choiceAction(String choice){
    if(choice == Constants.log_out){
      print('Déconnection');


      // Log Out User
      setState(() async {

        await  FirebaseAuth.instance.signOut().then((value) =>  Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade, child: LoginScreen()
          ),
        ));


      });

    }
  }

  @override
  Widget build(BuildContext context) {

     return Scaffold(

       appBar: AppBar(
         elevation: 0.0,
       //  shadowColor: Couleurs.buttonPageRetaurantColors,
         backgroundColor: Colors.white,

         iconTheme: IconThemeData(
           color: Couleurs.black,
         ),

           title:  Text(Chaines.app_nome, style: TextStyle(
               color: Couleurs.black,
               fontSize: 18,
               fontStyle: FontStyle.normal
           ), textAlign: TextAlign.center,),

           centerTitle: true,

           actions: <Widget>[
             PopupMenuButton<String>(
                   onSelected: choiceAction,
                   itemBuilder: (BuildContext context){
                     return Constants.choices.map((String choice){
                       return PopupMenuItem<String>(
                         value: choice,
                         child: Text(choice),
                       );
                     }).toList();
                   },
                 )
         ],

       ),

       drawer: Drawer(
         child: Column(
           children: [
             // Header
             Container(
             //  height: MediaQuery.of(context).size.height/3.2,
               child: DrawerHeader(
                 child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     // User name
                     Container(
                         margin: EdgeInsets.only(left: 5),
                         alignment: Alignment.bottomLeft,
                         child:
                     //    Text ( "Michel DOSSOU", style:  TextStyle (fontSize: 20, fontStyle: FontStyle.normal, color: Couleurs.corlor_app_green  ))

                         AutoSizeText(
                           (userName == null ) ? "" : userName!,
                          // FirebaseAuth.instance.currentUser.displayName,
                           style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal, color: Colors.black),
                           minFontSize: 18,
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                         )

                     ),

                     // User Adresse email
                     Container(
                         margin: EdgeInsets.only(left: 5),
                         alignment: Alignment.bottomLeft,
                         child:

                         //Text ( "micheldossou@gmail.com", style:  TextStyle (fontSize: 20, fontStyle: FontStyle.normal, color: Couleurs.corlor_app_green ))

                         AutoSizeText(
                           // "Michel",
                           FirebaseAuth.instance.currentUser!.email as String,
                           style: TextStyle(fontSize: 20,fontStyle: FontStyle.normal, color: Colors.black),
                           minFontSize: 18,
                           maxLines: 1,
                           overflow: TextOverflow.ellipsis,
                         )
                     ),
                   ],
                 ),
                 decoration: BoxDecoration(
                     color: Colors.black12,
                    // color: Couleurs.buttonPageRetaurantColors,
                 ),
               ),
             ),

             // Body

             // Mon compte
             InkWell(
               splashColor: Couleurs.buttonPageRetaurantColors,
               highlightColor:Couleurs.buttonPageRetaurantColors ,

               onTap: () {
                 setState(() {
                   changeSelected (0);

                   Navigator.push(
                     context,
                     PageTransition(
                       type: PageTransitionType.rightToLeft,
                       child: ProfilPage(),
                  //     child: Custom_Video_Model_PageScreen(),
                    //   child: Custom_Audio_Model_PageScreen(),
                     ),
                   );
                 });
               },

               child: ListTile(
                 selectedTileColor: Couleurs.buttonPageRetaurantColors,
                 selected: _selected == 0 ,
                 title: Text(Chaines.drawer_item_profil),
                 leading: Icon(Icons.account_circle_rounded, color: Colors.black),
                // leading: new Image.asset('Repertoires.assets_drawer_favoris'),
               ),
             ),

             // Contact
             InkWell(
               splashColor: Couleurs.buttonPageRetaurantColors,
               highlightColor:Couleurs.buttonPageRetaurantColors ,

               onTap: () {
                 setState(() {
                   changeSelected (1);

                   Navigator.push(
                     context,
                     PageTransition(
                       type: PageTransitionType.rightToLeft,
                       child: ContactPage(),
                  //     child: Custom_Video_Model_PageScreen(),
                    //   child: Custom_Audio_Model_PageScreen(),
                     ),
                   );
                 });
               },

               child: ListTile(
                 selectedTileColor: Couleurs.buttonPageRetaurantColors,
                 selected: _selected == 1 ,
                 title: Text(Chaines.drawer_item_contacte),
                 leading: Icon(Icons.phone, color: Colors.black),
                // leading: new Image.asset('Repertoires.assets_drawer_favoris'),
               ),
             ),

             // A propos
             InkWell(
               splashColor: Couleurs.buttonPageRetaurantColors,
               highlightColor:Couleurs.buttonPageRetaurantColors ,

               onTap: () {
                 setState(() {
                   changeSelected (2);

                   Navigator.push(
                     context,
                     PageTransition(
                       type: PageTransitionType.rightToLeft,
                       child: AboutPage(),
                  //     child: Custom_Video_Model_PageScreen(),
                    //   child: Custom_Audio_Model_PageScreen(),
                     ),
                   );
                 });
               },

               child: ListTile(
                 selectedTileColor: Couleurs.buttonPageRetaurantColors,
                 selected: _selected == 2 ,
                 title: Text(Chaines.drawer_item_apropos),
                 leading: Icon(Icons.info_rounded, color: Colors.black),
                // leading: new Image.asset('Repertoires.assets_drawer_favoris'),
               ),
             ),

             // Conditions d'utilisation
             InkWell(
               splashColor: Couleurs.buttonPageRetaurantColors,
               highlightColor:Couleurs.buttonPageRetaurantColors ,

               onTap: () {
                 setState(() {
                   changeSelected (3);

                   Navigator.push(
                     context,
                     PageTransition(
                       type: PageTransitionType.rightToLeft,
                       child: ConditionUtilisation(),
                  //     child: Custom_Video_Model_PageScreen(),
                    //   child: Custom_Audio_Model_PageScreen(),
                     ),
                   );
                 });
               },

               child: ListTile(
                 selectedTileColor: Couleurs.buttonPageRetaurantColors,
                 selected: _selected == 3 ,
                 title: Text(Chaines.drawer_item_condition),
                 leading: Icon(Icons.security, color: Colors.black),
                // leading: new Image.asset('Repertoires.assets_drawer_favoris'),
               ),
             ),

             // Politique de confidentialité
             InkWell(
               splashColor: Couleurs.buttonPageRetaurantColors,
               highlightColor:Couleurs.buttonPageRetaurantColors ,

               onTap: () {
                 setState(() {
                   changeSelected (4);

                   Navigator.push(
                     context,
                     PageTransition(
                       type: PageTransitionType.rightToLeft,
                       child: PolitiquePage(),
                  //     child: Custom_Video_Model_PageScreen(),
                    //   child: Custom_Audio_Model_PageScreen(),
                     ),
                   );
                 });
               },

               child: ListTile(
                 selectedTileColor: Couleurs.buttonPageRetaurantColors,
                 selected: _selected == 4 ,
                 title: Text(Chaines.drawer_item_politique),
                 leading: Icon(Icons.privacy_tip, color: Colors.black),
                // leading: new Image.asset('Repertoires.assets_drawer_favoris'),
               ),
             ),








             //  Separateur de ligne
             Divider(),

             SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

             // Version de l'application
             ListTile(
               leading: Icon(Icons.info),
               title: Text('Version'),
               subtitle: Text(_packageInfo.version,),
               onTap: () {},
             ),

           ],
         ),
       ),

       body:  Container(
                  color: Colors.black12,
                  margin: EdgeInsets.only(top:   ((MediaQuery.of(context).size.height * 0.02)*1.5),),
                  width: MediaQuery.of(context).size.width,

         child: Column(
           children: [

             // Assouka
             // Bienvenue
             Center(
               child: Container(
                margin:  EdgeInsets.only( left: 45, right: 45),
          //       margin:  EdgeInsets.only( left: 15, right: 15),
                 padding: EdgeInsets.all(25.0),
                 child: GestureDetector(
                   onTap: (){
                     setState(() {
                       print("OKKKK");
                     });
                   },
                   child: Text(

                     //Chaines.app_nome,
                     "Bienvenue",
                     style: GoogleFonts.adventPro(fontSize: 22,
                         fontWeight: FontWeight.normal,
                         fontStyle: FontStyle.normal
                     ), textAlign: TextAlign.center,),
                 ),

               ),
             ),


             // Liste of Cartegoris
             Expanded(
               child: Container(
             //    margin: EdgeInsets.only(left:15.0, right: 15.0,  bottom: 15.5),
                 margin: EdgeInsets.only(left:5.0, right: 5.0,  bottom: 0.0),
              // height: 0,
                 child: GridView.count(
                   childAspectRatio: 4/3,
                 //  childAspectRatio: 3/2,
                   scrollDirection: Axis.vertical,
                   crossAxisCount: 2 ,
                   children: List.generate(listmodels.length,(index){
                     return Container(
                       child: GestureDetector(
                         onTap: (){
                           setState(() {

                             print("bbbbbbbbbbbbbb");

                             // Mes restaurants
                             if (index == 0)
                               {

                                 Navigator.push(
                                   context,
                                   PageTransition(
                                     type: PageTransitionType.rightToLeft,
                                     child: MesRestaurantPage( userNameChef: userName ),
                                   ),
                                 );

                               } else

                           // Mes commandes
                             if (index == 1)
                               {
                                 Navigator.push(
                                   context,
                                   PageTransition(
                                     type: PageTransitionType.rightToLeft,
                                     child: MesCommandesPage(userNameChef: userName ),
                                   ),
                                 );

                               } else


                           // Ma comptabilité
                             if (index == 2)
                               {
                                 Navigator.push(
                                   context,
                                   PageTransition(
                                     type: PageTransitionType.rightToLeft,
                                     child: MaComptabilitePage(),
                                   ),
                                 );

                               }

                           // Mes retraires
                             if (index == 3)
                               {
                                 Navigator.push(
                                   context,
                                   PageTransition(
                                     type: PageTransitionType.rightToLeft,
                                     child: MesRetairesPage(),
                                   ),
                                 );

                               }


                           });
                         },
                         child: Card(
                           margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                           shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20.0),
                            ),
                           elevation: 12.0,
                           shadowColor: ( index  % 2 ==  0) ? Couleurs.buttonPageRetaurantColors : Couleurs.buttonPageRetaurantColors,
                          // color: Colors.white,
                           color: Colors.black,
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                             children: [
                               Center(
                                 child: Container(
                                     height: MediaQuery.of(context).size.height *0.15,
                                     decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only (topLeft: Radius.circular(15.0), topRight: Radius.circular(45.0),),
                                       image: DecorationImage(
                                         image: AssetImage(listmodels[index].image),
                                         fit: BoxFit.cover,
                                       ),
                                     ),
                                 ),
                               ),
                               Container(
                                 padding: EdgeInsets.only( left: 2.0, right: 2.0),
                                 child: Text(listmodels[index].name,  style: GoogleFonts.workSans(fontSize: 13,color: Colors.white,
                                     fontWeight: FontWeight.normal,
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
               ),
             ),


           ],
         ),
            ),

       // Hide floatinActionButton when keyboard is open
       floatingActionButton:   (WidgetsBinding.instance!.window.viewInsets.bottom > 0.0) ? Container() : ElevatedButton.icon(
         icon: Icon(Icons.thumb_up, color: Colors.red,),
         label: Text(Chaines.devenir_partenaire, style: TextStyle(color: Couleurs.black),),
         onPressed: () {
           Navigator.push(
             context,
             PageTransition(
                 type: PageTransitionType.rightToLeft,
                 child:  PartRestauration( userNameChef: userName )),
           );
         },
         style: ElevatedButton.styleFrom(
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(32.0),
           ),
           primary: Couleurs.buttonPageRetaurantColors,
         ),
       ),

    );
  }




  String lien_plateforme () {
    String android = 'https://play.google.com/store/apps/details?id=com.dcc.chretien_social';
    String ios  = 'https://apps.apple.com';
    //  String ios  = 'https://apps.apple.com/app/id<Apple ID>';

    if (Platform.isIOS)
      return ios;
    else
      return android ;
  }


/*
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

  }

 */

  // Facebook LogoOut
  /*
  Future<void> facebookSignout() async {
    await _auth.signOut().then((onValue) {
      setState(() {
        facebookLogin.logOut();
        //   isSignIn = false;
      });
    });
  }
*/

  Future<void> _initPackageInfo() async {


    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }


}

class Constants{
  static const String log_out = 'Déconnection';

  static const List<String> choices = <String>[
    log_out,
  ];
}



