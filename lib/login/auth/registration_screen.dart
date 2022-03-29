
import 'package:assouka_chef/login/auth/login_screen.dart';
import 'package:assouka_chef/login/model/user_model.dart';
import 'package:assouka_chef/ressources/Colors.dart';
import 'package:assouka_chef/ressources/Strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

import '../../home.dart';


class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String _email, _password, _name, _mobile;

  var _formkey = GlobalKey<FormState>();

  bool autoValidate = false;


  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("S'enregistrer", style: TextStyle(color: Colors.black),),
        backgroundColor: Couleurs.buttonPageRetaurantColors,
        //backgroundColor: Colors.lightGreenAccent,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
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
                  TextFormField(
                    keyboardType: TextInputType.text,
                    validator: (item) {
                      return item!.length > 0 ? null : "Votre nom";
                    },
                    onChanged: (item) {
                      setState(() {
                        _name = item;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Votre nom",
                        labelText: "Nom",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    maxLength: 14,
                    validator: (item) {
                      return item!.length < 08
                          ? "Votre numéro de télephone est invalide"
                          : null;
                    },
                    onChanged: (item) {
                      setState(() {
                        _mobile = item;
                      });
                    },
                    /*   inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],*/
                    decoration: InputDecoration(
                        hintText: "Votre numéro de téléphone",
                        labelText: "Numéro de téléphone",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (item) {
                      return item!.contains("@")
                          ? null
                          : "Votre adresse e-mail";
                    },
                    onChanged: (item) {
                      setState(() {
                        _email = item;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Votre e-mail",
                        labelText: "Email",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    validator: (item) {
                      return item!.length > 6
                          ? null
                          : "Le mot de passe doit comporter 6 caractères";
                    },
                    onChanged: (item) {
                      setState(() {
                        _password = item;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Votre mot de passe",
                        labelText: "Mot de passe",
                        border: OutlineInputBorder()),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: Couleurs.buttonPageRetaurantColors,
                      onPressed: () {
                        signup();
                      },
                      child: Text(
                        "S'enregister",
                      ),
                      textColor: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: GestureDetector(
                        onTap: () {

                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                child:  LoginScreen()),
                          );

                        },
                        child: Text("Se connecter ici")),
                    alignment: Alignment.centerRight,
                  )
                ],
              ),
            ),
          )
        ],
           // child: ,


          ),
    );
  }

  void signup() {
    if (_formkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      setState(() {
        autoValidate = false;
      });
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((user) {
        // sign up
        postUserDataToDb();
      }).catchError((onError) {
        setState(() {
          isLoading = false;
        });
        Fluttertoast.showToast(msg: "error " + onError.toString());
      });
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }

  void postUserDataToDb() async {
    setState(() {
      isLoading = true;
    });

    //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    User? firebaseUser = FirebaseAuth.instance.currentUser;

    UserModel userModel = new UserModel();
    userModel.email = _email;
    userModel.name = _name;
    userModel.mobileNumber = _mobile;
    userModel.uid = firebaseUser!.uid;

    // await FireStore.instance
    //     .collection("user")
    //     .document(firebaseUser.uid)
    //     .setData(userModel.toMap());

    await FirebaseFirestore.instance
        .collection(Collections.collectionUserChef)
        .doc(firebaseUser.uid)
        .set(userModel.toMap()).then((value) =>
        Navigator.pushReplacement(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeftWithFade,
              child:  HomePage()),
        ));

    Fluttertoast.showToast(msg: "Inscription réussie");

  //  await FirebaseUtils.updateFirebaseToken();

    sendVerificationEmail();

    setState(() {
      isLoading = false;
    });
  }

  void sendVerificationEmail() async {
    //FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    await firebaseUser!.sendEmailVerification();

    Fluttertoast.showToast(
        msg: "le lien de vérification par e-mail a été envoyé à votre adresse e-mail.");

   /* Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
        (Route<dynamic> route) => false);*/


  }
}
