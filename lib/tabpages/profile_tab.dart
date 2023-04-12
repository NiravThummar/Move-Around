import 'package:flutter/material.dart';
import 'package:move_around/global/global.dart';
import 'package:move_around/splashscreen/splash_screen.dart';
import 'package:move_around/widgets/info_design_ui.dart';

class ProfileTabPage extends StatefulWidget {
  const ProfileTabPage({Key? key}) : super(key: key);

  @override
  State<ProfileTabPage> createState() => _ProfileTabPageState();
}

class _ProfileTabPageState extends State<ProfileTabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Icon(Icons.person,
                size: 70,),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            const SizedBox(height: 20,),
            Text(
              onlineDriverData!.name!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              titleStarRating + " Driver",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 20,
              width: 200,
              child: Divider(
                color: Colors.white,
                height: 2,
                thickness: 2,
              ),
            ),
            const SizedBox(
              height: 38,
            ),
            InfoDesignUIWidget(
              textInfo: onlineDriverData!.phone!,
              iconData: Icons.phone_iphone,
            ),
            InfoDesignUIWidget(
              textInfo: onlineDriverData!.email!,
              iconData: Icons.email,
             ),
            InfoDesignUIWidget(
              textInfo: onlineDriverData.car_color! +
                  " " +
                  onlineDriverData.car_model! +
                  " " +
                  onlineDriverData.car_number!,
              iconData: Icons.car_repair,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              child: const Text(
                "Logout",
              ),
              onPressed: () {
                fAuth.signOut();
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const MySplashScreen()));
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
