import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newfp/FetchData.dart';
import 'package:newfp/models/booking_model.dart';

import 'add_booking.dart';

class UpdateBooking extends StatefulWidget {
  const UpdateBooking({super.key, required this.booking});

  final BookingModel booking;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Update(bookingModel: booking);
  }
}

class Update extends State<UpdateBooking> {
  Update({required this.bookingModel});

  BookingModel bookingModel;
  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController nameController = TextEditingController();
  TextEditingController timeStartController = TextEditingController();
  TextEditingController timeEndController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController centerController = TextEditingController();
  FetchData fetchData = FetchData();
  var youthCentersNames = ["شنواي", "الساقية", "كفر الحما"];
  bool adminValue = true;
  var dropdownValue = "شنواي";

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    timeStartController.dispose();
    timeEndController.dispose();
    mobileController.dispose();
    centerController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    timeStartController.text = bookingModel.timeStart.toString().trim();
    timeEndController.text = bookingModel.timeEnd.toString().trim();
    nameController.text = bookingModel.name.toString().trim();
    mobileController.text = bookingModel.mobile.toString().trim();
    dropdownValue = bookingModel.youthCenterId;
    super.initState();
  }

  Future update(BookingModel booking) async {
    await db
        .collection("Bookings")
        .doc(bookingModel.id)
        .set(booking.toJson())
        .whenComplete(
            () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Booking updated successfully "),
                  backgroundColor: Colors.redAccent,
                  elevation: 10, //shadow
                )))
        .onError((error, stackTrace) =>
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.redAccent,
              elevation: 10, //shadow
            )));
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
                    image: AssetImage("images/icon1.jpg"),
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          icon: Icon(Icons.person, color: Colors.red),
                          filled: true,
                          fillColor: Colors.amber,
                          hintText: "enter who booking name ")),
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
                          icon: Icon(Icons.phone, color: Colors.red),
                          filled: true,
                          fillColor: Colors.amber,
                          hintText: "enter who booking mobile ")),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      obscureText: false,
                      controller: timeStartController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          icon: Icon(
                            Icons.timer_rounded,
                            color: Colors.red,
                          ),
                          filled: true,
                          fillColor: Colors.amber,
                          hintText: "enter start time ex : 22:30")),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                      obscureText: false,
                      controller: timeEndController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          icon: Icon(
                            Icons.timer,
                            color: Colors.red,
                          ),
                          filled: true,
                          fillColor: Colors.amber,
                          hintText: "enter end  time ex : 22:30")),
                  const SizedBox(
                    height: 10,
                  ),
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
                        update(BookingModel(
                            name: nameController.text.toString().trim(),
                            mobile: mobileController.text.toString().trim(),
                            timeEnd: timeEndController.text.toString().trim(),
                            timeStart:
                                timeStartController.text.toString().trim(),
                            youthCenterId: dropdownValue.toString().trim()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      child: const Text("update Bookings",
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
