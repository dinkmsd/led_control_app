import 'dart:math';

import 'package:flutter/material.dart';
import 'package:led_control_app/models/led_model.dart';
import 'package:led_control_app/utils/app_color.dart';

double degToRad(double deg) => deg * (pi / 180.0);

double normalize(value, min, max) {
  print(((value - min) / (max - min)));
  return ((value - min) / (max - min));
}

const Color kScaffoldBackgroundColor = Color(0xFFF3FBFA);
const double kDiameter = 200;
const double kMinDegree = 16;
const double kMaxDegree = 28;

enum MQTTConnectionState { connected, disconnected, connecting }

enum AppConnectionState { connected, disconnected, connecting }

LedInfo tmp = LedInfo(
    id: '6566aec06d2075526cfe1331',
    name: "LED 3",
    lat: 10.876264682056627,
    lon: 106.8045361629442,
    temp: 30,
    humi: 70,
    brightness: 30,
    history: [],
    schedule: []);

TextStyle inclinationStyle = const TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white);

TextStyle networkStyle = const TextStyle(
    fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white);

TextStyle textColorBlack = const TextStyle(fontSize: 18, color: Colors.black);

TextStyle whiteTextStyle = const TextStyle(color: Colors.white);

TextStyle headerTextStyle = const TextStyle(
    fontSize: 24, fontWeight: FontWeight.w500, color: Colors.white);

ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
    textStyle: const TextStyle(color: Colors.white),
    foregroundColor: AppColors.buttonCustomColor.withOpacity(0.5),
    backgroundColor: AppColors.buttonCustomColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));

EdgeInsets contentPadding =
    const EdgeInsets.symmetric(vertical: 10, horizontal: 10);
// MQTTDetailState(
//           LedInfo: LedInfo(
//               id: '6566aec06d2075526cfe1331',
//               name: "LED 3",
//               lat: 10.876264682056627,
//               lon: 106.8045361629442,
//               temp: 30,
//               humi: 70,
//               brightness: 30,
//               history: [],
//               schedule: []))


// ListView.separated(
//               itemBuilder: (context, index) {
//                 return LedInfoItemWidget(
//                     item: LedInfo(
//                         id: '6566aec06d2075526cfe1331',
//                         name: "LED 3",
//                         lat: 10.876264682056627,
//                         lon: 106.8045361629442,
//                         temp: 30,
//                         humi: 70,
//                         brightness: 30,
//                         history: [],
//                         schedule: []));
//               },
//               separatorBuilder: (_, __) => const SizedBox(height: 10),
//               itemCount: 5)