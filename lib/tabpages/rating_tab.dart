import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move_around/global/global.dart';
import 'package:move_around/infoHandler/app_info.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';


class RatingTabPage extends StatefulWidget
{
  const RatingTabPage({Key? key}) : super(key: key);
  @override
  State<RatingTabPage> createState() => _RatingTabPageState();
}

class _RatingTabPageState extends State<RatingTabPage> {
  double ratingsNumber = 0;


  @override
  void initState() {
    super.initState();
    getRatingsNumber();
  }

  getRatingsNumber()
  {
    setState(() {
      ratingsNumber = double.parse(Provider.of<AppInfo>(context,listen: false).driverAverageRatings);
    });

    setupRatingsTitle();
  }

  setupRatingsTitle()
  {
    if(ratingsNumber == 1)
    {
      setState(() {
        titleStarRating ="Very Bad";
        Global.starColor = Colors.red;
        Global.borderColor = Colors.red;
        Global.textColor = Colors.red;
      });
    }
    if(ratingsNumber == 2)
    {
      setState(() {
        titleStarRating ="Bad";
        Global.starColor = Colors.orange;
        Global.borderColor = Colors.orange;
        Global.textColor = Colors.orange;
      });
    }
    if(ratingsNumber == 3)
    {
      setState(() {
        titleStarRating ="Good";
        Global.starColor = Colors.yellow;
        Global.borderColor = Colors.yellow;
        Global.textColor = Colors.yellow;
      });
    }
    if(ratingsNumber == 4)
    {
      setState(() {
        titleStarRating ="Very Good";
        Global.starColor = Colors.lightGreen;
        Global.borderColor = Colors.lightGreen;
        Global.textColor = Colors.lightGreen;
      });
    }
    if(ratingsNumber == 5)
    {
      setState(() {
        titleStarRating ="Excellent";
        Global.starColor = Colors.green;
        Global.borderColor = Colors.green;
        Global.textColor = Colors.green;
      });
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.white54,
        child: Container(
          margin:const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white60,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 22,),

              const Text(
                "Your Ratings",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontSize: 22,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 22,),

              const Divider(height: 4,thickness: 4,),

              const SizedBox(height: 22,),

              SmoothStarRating(
                rating:ratingsNumber,
                allowHalfRating: false,
                starCount: 5,
                color: Global.starColor,
                borderColor: Global.borderColor,
                size: 46,
              ),

              const SizedBox(height: 12,),

              // Text(
//                 titleStarRating,
//                 style:TextStyle(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: Global.textColor,
//                 ),
//               ),

              const SizedBox(height: 18,),

            ],
          ),
        ),
      ),
    );
  }
}
