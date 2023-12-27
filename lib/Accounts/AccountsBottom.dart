import 'package:flutter/material.dart';

class AccountsBottom extends StatefulWidget {
  @override
  _Bottom createState() => _Bottom();
}

class _Bottom extends State<AccountsBottom> {
  List<String> listHeading = [
    "",
    " Play Points ",
    " Earn Points ",
    " End Points ",
    " Profit ",
    " Agent Bonus ",
    " Net Points "
  ];

  List<String> account = [
    "", "12345", "56345", "1345", "2748.6", "0", "7845.2"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1000.0,
      child: Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) {
                double width = index == 0 ? 50.0 : 150.0;
                return Container(
                  margin: EdgeInsets.only(top: 20.0),
                  color: Colors.white,
                  width: width,
                  height: 30.0,
                  child: Text(
                    listHeading[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        
        Container(
          margin: EdgeInsets.fromLTRB(0, 3, 0, 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              7,
              (index) {
                double width = index == 0 ? 50.0 : 150.0;
                return Container(
                  margin: EdgeInsets.only(top: 5.0),
                  color: Colors.white,
                  width: width,
                  height: 30.0,
                  child: Text(
                    "${account[index]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        ElevatedButton(
          onPressed: () {},
          child: Text(
            "Print",
            style: TextStyle(
              fontFamily: "SansSerif",
              fontSize: 20.0,
            ),
          ),
        )
      ],
    ),
      ),
    );
  }
}
