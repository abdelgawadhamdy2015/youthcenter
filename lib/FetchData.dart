import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newfp/models/match_model.dart';
import 'package:newfp/models/user_model.dart';
import 'package:newfp/screen/add_booking.dart';
import 'package:newfp/screen/cups_screen.dart';
import 'package:newfp/screen/update_profile.dart';

class FetchData {
  FetchData();
  late CenterUser centerUser;
  late bool admin;
  late int values;



  PopupMenuItem buildPopupMenuItem(
      bool adminValue, int value, String title, IconData iconData) {
    admin = adminValue;
    values = value;
    return PopupMenuItem(
        value: value,
        child: Row(
          children: [
            Icon(iconData),
            const SizedBox(
              width: 10,
            ),
            Visibility(
                child: Text(
              title,
              style: getTextStyle(),
            ))
          ],
        ));
  }

  selectMinuItem(
      int value, BuildContext context, bool adminValue, CenterUser centerUser) {
    switch (value) {
      case 0:
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UpdateProfile()));
        break;

      case 1:
        if (admin) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddBooking(center: centerUser.youthCenterName)));
        }
        break;
      case 2:
        if (admin) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CupScreen(center: centerUser)));
        }
        break;
      case 3:
        FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacementNamed('/');
    }
  }

  String getScore(MatchModel matchModel, int i) {
    if (i == 1) {
      if (matchModel.time.toDate().isAfter(DateTime.now())) {
        return "-";
      } else {
        return matchModel.firstTeemScore.toString();
      }
    } else {
      if (matchModel.time.toDate().isAfter(DateTime.now())) {
        return "-";
      } else {
        return matchModel.secondTeemScore.toString();
      }
    }
  }

  getTextStyle() {
    if (values == 1 && !admin) {
      return const TextStyle(color: Colors.grey);
    }
  }



  List<dynamic> listToJson(List<MatchModel> matches) {
    List<dynamic> lisoOfJsonMatches = [];

    for (var e in matches) {
      lisoOfJsonMatches.add(e.toJson());
    }

    return lisoOfJsonMatches;
  }


  String getDateTime(DateTime dateTime) {
    String dateTimeStr = ("${dateTime.day} "
        "/ ${dateTime.month} "
        "/ ${dateTime.year}"
        "\n ${dateTime.hour}"
        ": ${dateTime.minute}");
    return dateTimeStr;
  }
}
