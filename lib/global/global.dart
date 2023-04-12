import 'dart:async';
import 'dart:ui';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:move_around/models/driver_data.dart';
import 'package:move_around/models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
userModel? userModelCurrentInfo;
StreamSubscription<Position>? streamSubscriptionPosition;
StreamSubscription<Position>? streamSubscriptionDriverLivePosition;
AssetsAudioPlayer audioPlayer=AssetsAudioPlayer();
Position? driverCurrentPosition;
DriverData onlineDriverData =DriverData();
String? driverVehicleType = "";
String titleStarRating = "Good";
bool isDriverActive= false;
String statusText = "Now Offline";
Color buttonColor=Colors.grey;

class Global
{
  static var textColor = Colors.red;
  static var starColor = Colors.red;
  static var borderColor = Colors.red;
}