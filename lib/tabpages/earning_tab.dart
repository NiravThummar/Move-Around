import 'package:flutter/material.dart';
import 'package:move_around/infoHandler/app_info.dart';
import 'package:move_around/mainscreen/trips_history_screen.dart';
import 'package:provider/provider.dart';

class EarningTabPage extends StatefulWidget {
  const EarningTabPage({Key? key}) : super(key: key);

  @override
  State<EarningTabPage> createState() => _EarningTabPageState();
}

class _EarningTabPageState extends State<EarningTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          Container(
            color: Colors.black,
            width: double.infinity,
            child: Padding(
              padding:const EdgeInsets.symmetric(vertical: 80),
              child: Column(
                children: [
                  const Text(
                    "Your Earning",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 10,),

                  Text(
                    Provider.of<AppInfo>(context,listen: false).driverTotalEarnings + " \u{20B9}",
                    style:const TextStyle(
                      color: Colors.grey,
                      fontSize: 50,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton(
            onPressed: ()
            {
              Navigator.push(context,MaterialPageRoute(builder: (c) => TripsHistoryScreen()));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white54,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Row(
                children: [
                  Image.asset("assets/images/car_logo.png",width: 100,),

                  const SizedBox(width: 25,),

                  const Text(
                    "Trips Completed",
                    style:const TextStyle(
                      color: Colors.black87,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: Text(
                        Provider.of<AppInfo>(context,listen: false).allTripsHistoryInformationList.length.toString(),
                        textAlign: TextAlign.end,
                        style:const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
