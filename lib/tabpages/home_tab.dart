import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:move_around/assistant/assistant_method.dart';
import 'package:move_around/assistant/black_theme_google_map.dart';
import 'package:move_around/global/global.dart';
import 'package:move_around/push_notifications/push_notification_system.dart';


class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {

  GoogleMapController? newGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  var geoLocator = Geolocator();
  LocationPermission? _locationPermission;

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateDriverPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    driverCurrentPosition = cPosition;

    LatLng latLngPosition =
    LatLng(driverCurrentPosition!.latitude, driverCurrentPosition!.longitude);
    CameraPosition cameraPosition =
    CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    String humanReadableAddress = await AssistantMethods.searchAddForGeographicCoordinates(driverCurrentPosition!, context);
    print("This is your address= " + humanReadableAddress);

    AssistantMethods.readDriverEarnings(context);

  }

  readCurrentDriverInformation() async
  {
    currentFirebaseUser = fAuth.currentUser;
    FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .once()
        .then((snap){
      if(snap.snapshot.value != null)
        {
          onlineDriverData.id = (snap.snapshot.value as Map)["id"];
          onlineDriverData.name = (snap.snapshot.value as Map)["name"];
          onlineDriverData.phone = (snap.snapshot.value as Map)["phone"];
          onlineDriverData.email = (snap.snapshot.value as Map)["email"];
          onlineDriverData.car_color = (snap.snapshot.value as Map)["car_details"]["car_color"];
          onlineDriverData.car_model = (snap.snapshot.value as Map)["car_details"]["car_model"];
          onlineDriverData.car_number = (snap.snapshot.value as Map)["car_details"]["car_number"];

          driverVehicleType = (snap.snapshot.value as Map)["car_details"]["type"];

          print("Car details:");
          print(onlineDriverData.car_color);
        }
    }
    );

    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
    pushNotificationSystem.initializeCloudMessaging(context);
    pushNotificationSystem.generateAndGetToken();

    AssistantMethods.readDriverEarnings(context);
  }

  @override
  void initState()
  {
    super.initState();
    checkIfLocationPermissionAllowed();
    readCurrentDriverInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationEnabled: true,
          initialCameraPosition:_kGooglePlex,
          onMapCreated: (GoogleMapController controller)
          {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController=controller;
            blackThemeGoogleMap(newGoogleMapController);

            locateDriverPosition();
          },
        ),

        statusText!="Now Online"
        ? Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          color: Colors.black87,
        )
        : Container(),

        Positioned(
          top: statusText!="Now Online"
              ? MediaQuery.of(context).size.height*0.45
              : 25,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: ()
                {
                  if(isDriverActive !=true)
                    {
                      driverIsOnlineNow();
                      updateDriversLocationAtRealTime();

                      setState(() {
                        statusText="Now Online";
                        isDriverActive = true;
                        buttonColor = Colors.transparent;
                      });

                      Fluttertoast.showToast(msg: "You are Online Now");
                    }
                  else
                    {
                      driverIsOfflineNow();
                      setState(() {
                        statusText="Now Offline";
                        isDriverActive = false;
                        buttonColor = Colors.grey;
                      });

                      Fluttertoast.showToast(msg: "You are Offline Now");
                    }
                },
                style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 20,),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: statusText!="Now Online"
                    ? Text(
                      statusText,
                      style:const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                    :const Icon(
                    Icons.phonelink_ring,
                    color: Colors.white,
                    size: 26,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  driverIsOnlineNow() async
  {
    Position pos=await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    driverCurrentPosition =pos;

    Geofire.initialize("activeDrivers");
    Geofire.setLocation(
        currentFirebaseUser!.uid,
        driverCurrentPosition!.latitude,
        driverCurrentPosition!.longitude
    );

    DatabaseReference ref=FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("newRideStatus");

    ref.set("idle");
    ref.onValue.listen((event) {});
  }

  updateDriversLocationAtRealTime()
  {
    streamSubscriptionPosition = Geolocator.getPositionStream()
        .listen((Position position)
    {
      driverCurrentPosition =position;

      if(isDriverActive == true)
        {
          Geofire.setLocation(
              currentFirebaseUser!.uid,
              driverCurrentPosition!.latitude,
              driverCurrentPosition!.longitude
          );
        }

      LatLng latLng=LatLng(
        driverCurrentPosition!.latitude,
        driverCurrentPosition!.longitude,
      );

      newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  driverIsOfflineNow()
  {
    Geofire.removeLocation(currentFirebaseUser!.uid);
    DatabaseReference? ref=FirebaseDatabase.instance.ref()
        .child("drivers")
        .child(currentFirebaseUser!.uid)
        .child("newRideStatus");
    ref.onDisconnect();
    ref.remove();
    ref=null;

    Future.delayed(const Duration(milliseconds: 2000), ()
    {
      // SystemChannels.platform.invokeMethod("SystemNavigator.pop");
      SystemNavigator.pop();
    });
  }
}
