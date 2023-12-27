import 'package:bet/providers/game_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Check_Button.dart';

class HomeLeft extends StatefulWidget {
  const HomeLeft({super.key});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<HomeLeft> {
  @override
  Widget build(BuildContext context) {
    // final select = Provider.of<GameSelector>(context);
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: mediaQuery.size.width * 0.125,
            height: mediaQuery.size.height * 0.05,
            margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.yellow, width: 2.0),
                borderRadius: BorderRadius.circular(2.0)),
            child: Consumer<GameSelector>(
              builder: (context, select, child) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: select.atIsChecked,
                          checkColor: Colors.black,
                          onChanged: (bool? value) {
                            select.toggleAT(value);
                          },
                          fillColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      const Text(
                        "A TO T",
                        style: TextStyle(
                            fontFamily: "SansSerif",
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )
                    ],
                  ),
                );
              },
            )),
        Container(
          width: mediaQuery.size.width * 0.125,
          height: mediaQuery.size.height * 0.05,
          margin: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(2.0)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: mediaQuery.size.width * 0.06,
                height: 38.0,
                alignment: Alignment.center,
                color: Colors.green,
                child: const Text("Pg. Up",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
              Container(
                width: mediaQuery.size.width * 0.06,
                height:  mediaQuery.size.height * 0.05,
                alignment: Alignment.center,
                color: Colors.yellow[600],
                child: const Text("Pg. Down",
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ),
            ],
          ),
        ),
        for (int i = 0; i < 10; ++i) ...[
          Consumer<GameSelector>(
            builder: (context, select, child) {
              return Container(
                width: mediaQuery.size.width * 0.125,
                height:  mediaQuery.size.height * 0.05,
                margin: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Check_Button(
                        width: mediaQuery.size.width * 0.0625,
                        height:  mediaQuery.size.height * 0.05,
                        isChecked: select.atIsChecked || select.ajIsChecked
                            ? true
                            : select.activeMatrix == select.checkbox[i],
                        text: select.checkbox[i],
                        onChange: (bool? value) {
                          // activeMatrix.clear();
                          if (select.atIsChecked ||
                              select.ajIsChecked ||
                              select.ktIsChecked) {
                            return;
                          }
                          select.prevActiveMatrix = select.activeMatrix;
                          select.activeMatrix = select.checkbox[i];
                          select.handleCheckboxChange(
                              select.checkbox[i], value);
                        }),
                    Check_Button(
                        width: mediaQuery.size.width * 0.0625,
                        height:  mediaQuery.size.height * 0.05,
                        isChecked: select.atIsChecked || select.ktIsChecked
                            ? true
                            : select.activeMatrix == select.checkbox[i + 10],
                        text: select.checkbox[i + 10],
                        onChange: (bool? value) {
                          if (select.atIsChecked ||
                              select.ajIsChecked ||
                              select.ktIsChecked) {
                            return;
                          }
                          // activeMatrix.clear();
                          select.prevActiveMatrix = select.activeMatrix;
                          select.activeMatrix = select.checkbox[i + 10];
                          select.handleCheckboxChange(
                              select.checkbox[i + 10], value);
                        }),
                  ],
                ),
              );
            },
          ),
        ],
      ],
    );
  }
}
