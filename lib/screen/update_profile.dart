import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newfp/FetchData.dart';

import '../models/user_model.dart';
import 'add_booking.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Update();
  }
}

class Update extends State<UpdateProfile> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  var youthCentersNames = ["شنواي", "الساقية", "كفر الحما"];
  var dropdownValue = "شنواي";
  late CenterUser centerUser;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> minuItems = ["الصفحة الرئيسية", "إضافة حجز", "تسجيل خروج"];

  FetchData fetchData=FetchData();
  bool adminValue=false;

  //late Future<DocumentSnapshot<Map<String, dynamic>>> snapshot;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    usernameController.dispose();
    mobileController.dispose();
    nameController.dispose();
  }

  @override
  void initState() {
    super.initState();

    getUser();
    // TODO: implement initState
    /*nameController.text = centerUser.name.toString().trim();
    mobileController.text = centerUser.mobile.toString().trim();
    dropdownValue = centerUser.youthCenterName.toString().trim();*/
  }

  Future updateMyProfile(CenterUser centerUser) async {
    await db
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(centerUser.toJson())
        .whenComplete(
            () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Profile updated successfully "),
                  backgroundColor: Colors.redAccent,
                  elevation: 10, //shadow
                )));
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
        setState(() {
          usernameController.text = centerUser.email.toString().trim();
          nameController.text = centerUser.name.toString().trim();
          mobileController.text = centerUser.mobile.toString().trim();
          dropdownValue = centerUser.youthCenterName.toString().trim();
          adminValue=centerUser.admin;
        //  print(centerUser.name);
        });
      } else {
        print("error: no document found");
      }
    });
    /* */ /*Stream documentStream =db.collection('Users').doc(FirebaseAuth.instance.currentUser!.uid.toString()).snapshots();
    centerUser =documentStream.first as CenterUser;*/ /*
    json = db.collection("Users").doc(FirebaseAuth.instance.currentUser!.uid)
        .withConverter<CenterUser>(
        fromFirestore: (sna _),
        toFirestore: toFirestore)
        .get()
        .then((value) => value.data());
    CenterUser.fromJson(json)*/
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Youth Center"),
        backgroundColor: Colors.amber,
       /* actions: [
          PopupMenuButton(
            color: Colors.amberAccent,
            itemBuilder: (context) {
              return [
                fetchData.buildPopupMenuItem(
                    adminValue, 0, "حسابي", Icons.account_circle_outlined),
                fetchData.buildPopupMenuItem(
                    adminValue, 1, "الصفحة الرئيسية", Icons.home),
                fetchData.buildPopupMenuItem(
                    adminValue, 2, "اضافة حجز", Icons.add),
                fetchData.buildPopupMenuItem(
                    adminValue, 3, "تسجيل خروج", Icons.logout),
              ];
            },
            onSelected: (value) {
              switch (value) {
                case 0:
                  Navigator.of(context).pushReplacementNamed('updateProfile');
                  break;
                case 1:
                  Navigator.of(context).pushReplacementNamed('homeScreen');
                  break;
                case 2:
                  if (adminValue) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddBooking(
                                center: centerUser.youthCenterName)));
                  }
                  break;
                case 3:
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacementNamed('/');
              }
            },
          )
        ],*/
      ),
      /*drawer: Drawer(
        shape: const BeveledRectangleBorder(side: BorderSide()),
        child: Center(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(30)),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('updateProfile');
                  },
                  child: const Text(
                    "My Profile",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('homeScreen');
                  },
                  child: const Text(
                    "Home screen",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                  )),
              MaterialButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    "Sign out",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                  )),
              MaterialButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('addBooking');
                  },
                  child: const Text(
                    "add Booking",
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                  ))
            ],
          ),
        ),
      ),*/
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/3f.jpg"), fit: BoxFit.cover)),
        alignment: AlignmentDirectional.topStart,
        padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("images/icon3.jpg"),
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          icon: Icon(Icons.person, color: Colors.red),
                          filled: true,
                          fillColor: Colors.amber,
                          hintText: "Email")),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      obscureText: false,
                      controller: nameController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          icon: Icon(
                            Icons.nature,
                            color: Colors.red,
                          ),
                          filled: true,
                          fillColor: Colors.amber,
                          hintText: "name")),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      obscureText: false,
                      controller: mobileController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          icon: Icon(
                            Icons.phone_in_talk_rounded,
                            color: Colors.red,
                          ),
                          filled: true,
                          fillColor: Colors.amber,
                          hintText: "mobile")),
                  Container(
                    color: Colors.amber,
                    child: DropdownButton<String>(
                        // Step 3.
                        value: dropdownValue,
                        icon: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: Colors.purple,
                        ),
                        // Step 4.
                        items: youthCentersNames
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(fontSize: 30),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        }),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        updateMyProfile(CenterUser(
                            admin: centerUser.admin,
                            name: nameController.text.toString().trim(),
                            email: usernameController.text.toString().trim(),
                            mobile: mobileController.text.toString().trim(),
                            youthCenterName: dropdownValue));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        //foregroundColor: Colors.black,
                      ),
                      child: const Text("Update my profile",
                          style: TextStyle(fontSize: 15, color: Colors.blue)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
