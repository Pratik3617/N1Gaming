import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'ResultDisplayBlock.dart';
import '../API/RecentResultAPI.dart';
import 'package:intl/intl.dart';


class HomeRight extends StatefulWidget {
  HomeRightState createState() => HomeRightState();
}

class HomeRightState extends State<HomeRight> {
  List<dynamic> recentResultData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await recentResult();
      recentResultData = response['result'][0];
      if (recentResultData.isNotEmpty) {
        String originalTime = recentResultData[0].toString();

      DateTime parsedTime = DateFormat('HH:mm:ss').parse(originalTime);

      String formattedTime = DateFormat('hh:mm a').format(parsedTime);

      recentResultData[0] = formattedTime;
      }
    } catch (e) {
      print('Error during fetching recent data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: mediaQuery.size.width * 0.135,
          height: mediaQuery.size.height * 0.05,
          margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
          decoration: BoxDecoration(
            color: Colors.green,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: const Padding(
            padding: EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Results",
                  style: TextStyle(
                    fontFamily: "SansSerif",
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
        Container(
          width: mediaQuery.size.width * 0.137,
          height: mediaQuery.size.height * 0.05,
          margin: const EdgeInsets.fromLTRB(6.0, 2.0, 0.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: mediaQuery.size.width * 0.135,
        
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      recentResultData.isNotEmpty
                          ? "${recentResultData[0].toString()}"
                          : "No data available",
                      style: TextStyle(
                        fontFamily: "SansSerif",
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Result_Display_Box(text1: "A", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[1].toString()}"
                          : "", text3: "K", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[11].toString()}"
                          : ""),
        Result_Display_Box(text1: "B", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[2].toString()}"
                          : "", text3: "L", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[12].toString()}"
                          : ""),
        Result_Display_Box(text1: "C", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[3].toString()}"
                          : "", text3: "M", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[13].toString()}"
                          : ""),
        Result_Display_Box(text1: "D", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[4].toString()}"
                          : "", text3: "N", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[14].toString()}"
                          : ""),
        Result_Display_Box(text1: "E", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[5].toString()}"
                          : "", text3: "O", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[15].toString()}"
                          : ""),
        Result_Display_Box(text1: "F", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[6].toString()}"
                          : "", text3: "P", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[16].toString()}"
                          : ""),
        Result_Display_Box(text1: "G", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[7].toString()}"
                          : "", text3: "Q", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[17].toString()}"
                          : ""),
        Result_Display_Box(text1: "H", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[8].toString()}"
                          : "", text3: "R", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[18].toString()}"
                          : ""),
        Result_Display_Box(text1: "I", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[9].toString()}"
                          : "", text3: "S", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[19].toString()}"
                          : ""),
        Result_Display_Box(text1: "J", text2: recentResultData.isNotEmpty
                          ? "${recentResultData[10].toString()}"
                          : "", text3: "T", text4: recentResultData.isNotEmpty
                          ? "${recentResultData[20].toString()}"
                          : ""),
      ],
    );
  }
}
