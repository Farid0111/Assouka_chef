import 'package:assouka_chef/model/restaurant.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'mesRestaurants/mesRestaurantPrincipalHome.dart';

//import 'package:intl/intl.dart';

class MesRestaurantPage extends StatefulWidget {
  const MesRestaurantPage({Key? key, String? userNameChef}) : super(key: key);

  @override
  _MesRestaurantPageState createState() => _MesRestaurantPageState();
}

class _MesRestaurantPageState extends State<MesRestaurantPage> {

  final Stream<QuerySnapshot> _lastEventStream = FirebaseFirestore.instance.collection(Chaines.restaurant_Collection).orderBy("timestamp", descending: true).limit(30).snapshots();



  @override
  void initState() {

    menuItems = [
      ItemModel('发起群聊', Icons.chat_bubble),
      ItemModel('添加朋友', Icons.group_add),
      ItemModel('扫一扫', Icons.settings_overscan),
    ];

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text("Mes restaurants", style: TextStyle(color: Colors.black),),
          backgroundColor: Couleurs.buttonPageRetaurantColors,
          //backgroundColor: Colors.lightGreenAccent,
          iconTheme: IconThemeData(
              color: Colors.black
          ),
        ),
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

                            Restaurant resto = new Restaurant(

                              userUID: data['userUID'],
                              localisation: data['localisation'],
                              numero_telephone: data['mobileNumber'],
                              uid: data['uid'],
                              slogant: data['slogant'],
                              activer: data['activer'],
                              cartegory: data['cartegory'],
                              name: data['name'],
                              nameChef: data['chefName'],
                              registre_commerce: data['RCCM'],
                              like_counpteur: data['like_counpteur'],
                              date_ajout: data['date_ajout'].toString(),

                            )  ;

                            if(FirebaseAuth.instance.currentUser!.uid == resto.userUID )
                            return


                              Card(
                                  elevation: 10,
                                  margin: EdgeInsets.only(right: 15, left: 15, top: 5, bottom: 5),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(25.0),topRight: Radius.circular(25.0), ),
                                  ),
                                  // color: Colors.white,
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
                                            child:  MesRestaurantHomePrincipalPage( userNameChef: resto.nameChef ,resto: resto,),
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
                                      Row(
                                        children: [
                                          Text("Statut"),
                                          SizedBox(width: 10,),
                                          Icon(Icons.check_circle_outline, color: resto.activer == true  ? Colors.green : Colors.red, size: 30,)
                                        ],
                                      ),
                                      Text(
                                         data['date_ajout'].toString()

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
                                        print("${resto.name}");
                                       Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.rightToLeft,
                                              child: MesRestaurantHomePrincipalPage(resto: resto,),
                                              inheritTheme: true,
                                              ctx: context),
                                        );
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
        )
    );
  }

  CustomPopupMenuController _controller = CustomPopupMenuController();


  Widget ggh ()
  {
    return CustomPopupMenu(
      child: Container(
        padding: EdgeInsets.all(10),
        constraints: BoxConstraints(maxWidth: 240, minHeight: 40),
        decoration: BoxDecoration(
          color: Color(0xff98e165) ,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Text('message.content'),
      ),
      menuBuilder: _buildLongPressMenu,
      barrierColor: Colors.transparent,
      pressType: PressType.longPress,
    );
  }


  Widget _buildLongPressMenu() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: 220,
        color: const Color(0xFF4C4C4C),
        child: GridView.count(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          crossAxisCount: 5,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: menuItems
              .map((item) => Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                item.icon,
                size: 20,
                color: Colors.white,
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  item.title,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ))
              .toList(),
        ),
      ),
    );
  }


  List<ItemModel> menuItems = [
    ItemModel('复制', Icons.content_copy),
    ItemModel('转发', Icons.send),
    ItemModel('收藏', Icons.collections),
    ItemModel('删除', Icons.delete),
    ItemModel('多选', Icons.playlist_add_check),
    ItemModel('引用', Icons.format_quote),
    ItemModel('提醒', Icons.add_alert),
    ItemModel('搜一搜', Icons.search),
  ];
}

class ItemModel {
  String title;
  IconData icon;

  ItemModel(this.title, this.icon);
}