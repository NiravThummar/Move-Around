import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:move_around/models/trips_history_model.dart';


class HistoryDesignUiWidget extends StatefulWidget {
  TripsHistoryModel? tripsHistoryModel;
  HistoryDesignUiWidget({this.tripsHistoryModel});

  @override
  State<HistoryDesignUiWidget> createState() => _HistoryDesignUiWidgetState();
}

class _HistoryDesignUiWidgetState extends State<HistoryDesignUiWidget> {
  String formatDateAndTime(String dateTimeFromDB)
  {
    DateTime dateTime =DateTime.parse(dateTimeFromDB);

    String formattedDateTime = "${DateFormat.MMMd().format(dateTime)},${DateFormat.y().format(dateTime)} - ${DateFormat.jm().format(dateTime)},";
    return formattedDateTime;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      padding:const EdgeInsets.symmetric(
        horizontal: 10,vertical: 10
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 6),
                child: Text(
                  "User : " + widget.tripsHistoryModel!.userName!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(width: 12,),

              Text(
                widget.tripsHistoryModel!.fareAmount! + " \u{20B9}",
                style:const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                ),
              ),
            ],
          ),

          const SizedBox(height: 4,),

          Row(
            children: [
              const Icon(
                Icons.phone_android_rounded,
                color: Colors.black,
                size: 28,
              ),

              const SizedBox(width: 12,),

              Text(
                widget.tripsHistoryModel!.userPhone!,
                style:const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18,),

          Row(
            children: [
              Image.asset(
                "assets/images/origin.png",
                height: 26,
                width: 26,
              ),

              const SizedBox(width: 12,),

              Expanded(
                child: Container(
                  child: Text(
                    widget.tripsHistoryModel!.originAddress!,
                    overflow: TextOverflow.ellipsis,
                    style:const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 14,),

          Row(
            children: [
              Image.asset(
                "assets/images/destination.png",
                height: 24,
                width: 24,
              ),

              const SizedBox(width: 12,),

              Expanded(
                child: Container(
                  child: Text(
                    widget.tripsHistoryModel!.destinationAddress!,
                    overflow: TextOverflow.ellipsis,
                    style:const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "",
              ),
              Text(
                formatDateAndTime(widget.tripsHistoryModel!.time!),
                style:const TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),

          const SizedBox(height: 2,),

        ],
      ),
    );
  }
}
