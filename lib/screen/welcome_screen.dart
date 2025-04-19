import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newfp/FetchData.dart';
import 'package:newfp/models/match_model.dart';
import 'package:newfp/screen/HomeScreen.dart';

import '../models/user_model.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Welcome();
  }
}

class Welcome extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  FirebaseFirestore db = FirebaseFirestore.instance;

  FetchData fetchDate = FetchData();

  List<String> youthCentersNames = [];
  late  CenterUser centerUser;
  bool userDone=false;

  var isLiked=false;


  @override
  void initState() {
    super.initState();
    centerUser=const CenterUser(name: "0", mobile: "0", email: "0", youthCenterName: "0", admin: false);
    getUser();
  }

  getUser() async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        String json = jsonEncode(documentSnapshot.data());
        Map<String, dynamic>? c = jsonDecode(json);
        centerUser = CenterUser.fromJson(c!);
        userDone=true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return   Scaffold(
        body :getWidget());


  }

  Widget getWidget(){
    if(!userDone){
      Future.delayed(Duration(seconds: 3),() {

        setState(() {

        });


      },);
      return const Center(child: Image(image: AssetImage("images/logo.jpg"),));



    }

    return const  HomeScreen();

  }
}
