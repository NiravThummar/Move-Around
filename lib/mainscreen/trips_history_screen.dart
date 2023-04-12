import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move_around/infoHandler/app_info.dart';
import 'package:move_around/tabpages/earning_tab.dart';
import 'package:move_around/widgets/history_design_ui.dart';
import 'package:provider/provider.dart';

class TripsHistoryScreen extends StatefulWidget {

  @override
  State<TripsHistoryScreen> createState() => _TripsHistoryScreenState();
}

class _TripsHistoryScreenState extends State<TripsHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Trips History",
        ),
        leading: IconButton(
          icon:const Icon(
            Icons.close,
          ),
          onPressed: ()
          {
            Navigator.push(context,MaterialPageRoute(builder: (c) => EarningTabPage()));
          },
        ),
      ),

      body: ListView.separated(
        separatorBuilder: (context,i) =>
        const Divider(
          color: Colors.black87,
          thickness: 2,
          height: 2,
        ),
        itemBuilder: (context,i)
        {
          return Card(
            color: Colors.white54,
            child: HistoryDesignUiWidget(
              tripsHistoryModel: Provider.of<AppInfo>(context,listen: false).allTripsHistoryInformationList[i],
            ),
          );
        },
        itemCount: Provider.of<AppInfo>(context,listen: false).allTripsHistoryInformationList.length,
        physics:const ClampingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
