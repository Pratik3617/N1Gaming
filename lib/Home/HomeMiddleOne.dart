import 'package:bet/providers/game_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Input_Box.dart';
import 'Button.dart';

class HomeMiddleOne extends StatefulWidget {
  const HomeMiddleOne({
    super.key,
    required this.matrixControllers,
    required this.context,
    required this.rowControllers,
    required this.columnControllers,
  });
  final List<List<TextEditingController>> matrixControllers;
  final BuildContext context;
  final List<TextEditingController> rowControllers;
  final List<TextEditingController> columnControllers;

  @override
  RandomNumberGenerator createState() =>
      RandomNumberGenerator(context: context);
}

class RandomNumberGenerator extends State<HomeMiddleOne> {
  final BuildContext context;
  // final List<TextEditingController> rowControllers =
  //     List.generate(10, (index) => TextEditingController());
  // final List<TextEditingController> columnControllers =
  //     List.generate(10, (index) => TextEditingController());


  RandomNumberGenerator({required this.context});

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 10; i++) {
      widget.rowControllers[i].addListener(() {
        _updateMatrixForRow(i);
      });

      widget.columnControllers[i].addListener(() {
        _updateMatrixForColumn(i);
      });
    }
    _fillDisplayMatrix();
  }

  _fillDisplayMatrix() {
    final matrixList =
        Provider.of<GameSelector>(context, listen: false).matrixList;

    for (int i = 0; i < 10; i++) {
      for (int j = 0; j < 10; j++) {
        widget.matrixControllers[i][j].text = matrixList[0][i][j].toString();
      }
    }
  }

  _updateMatrixForRow(int rowIndex) {
  final c = Provider.of<GameSelector>(context, listen: false);
  for (int j = 0; j < 10; j++) {
    if (c.evenIsChecked) {
      if (j % 2 == 0) {
        int sum = (int.tryParse(widget.rowControllers[rowIndex].text) ?? 0) +
            (int.tryParse(widget.columnControllers[j].text) ?? 0);
        widget.matrixControllers[rowIndex][j].text = (sum != 0) ? sum.toString() : "";
      }
    } else if (c.oddIsChecked) {
      if (j % 2 != 0) {
        int sum = (int.tryParse(widget.rowControllers[rowIndex].text) ?? 0) +
            (int.tryParse(widget.columnControllers[j].text) ?? 0);
        widget.matrixControllers[rowIndex][j].text = (sum != 0) ? sum.toString() : "";
      }
    } else {
      int sum = (int.tryParse(widget.rowControllers[rowIndex].text) ?? 0) +
          (int.tryParse(widget.columnControllers[j].text) ?? 0);
      widget.matrixControllers[rowIndex][j].text = (sum != 0) ? sum.toString() : "";
    }
  }
}

_updateMatrixForColumn(int columnIndex) {
  final c = Provider.of<GameSelector>(context, listen: false);
  for (int i = 0; i < 10; i++) {
    if (c.evenIsChecked) {
      if (i % 2 == 0) {
        int sum = (int.tryParse(widget.rowControllers[i].text) ?? 0) +
            (int.tryParse(widget.columnControllers[columnIndex].text) ?? 0);
        widget.matrixControllers[i][columnIndex].text = (sum != 0) ? sum.toString() : "";
      }
    } else if (c.oddIsChecked) {
      if (i % 2 != 0) {
        int sum = (int.tryParse(widget.rowControllers[i].text) ?? 0) +
            (int.tryParse(widget.columnControllers[columnIndex].text) ?? 0);
        widget.matrixControllers[i][columnIndex].text = (sum != 0) ? sum.toString() : "";
      }
    } else {
      int sum = (int.tryParse(widget.rowControllers[i].text) ?? 0) +
          (int.tryParse(widget.columnControllers[columnIndex].text) ?? 0);
      widget.matrixControllers[i][columnIndex].text = (sum != 0) ? sum.toString() : "";
    }
  }
}
  

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final select = Provider.of<GameSelector>(context, listen: false);
    
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: mediaQuery.size.width * 0.09,
                    height: mediaQuery.size.height * 0.05,
                    margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.yellow, width: 2.0),
                        borderRadius: BorderRadius.circular(2.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              checkColor: Colors.black,
                              value: select.ajIsChecked,
                              onChanged: (bool? value) =>
                                  select.toggleAJ(value),
                              fillColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          const Text(
                            "A TO J",
                            style: TextStyle(
                                fontFamily: "SansSerif",
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    )),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: mediaQuery.size.width * 0.09,
                    height: mediaQuery.size.height * 0.05,
                    margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.yellow, width: 2.0),
                        borderRadius: BorderRadius.circular(2.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              checkColor: Colors.black,
                              value: select.ktIsChecked,
                              onChanged: (bool? value) =>
                                  select.toggleKT(value),
                              fillColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          const Text(
                            "K TO T",
                            style: TextStyle(
                                fontFamily: "SansSerif",
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    )),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: mediaQuery.size.width * 0.17,
                  height: mediaQuery.size.height * 0.05,
                  margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(2.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: mediaQuery.size.width * 0.05,
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                checkColor: Colors.black,
                                value: select.allIsChecked,
                                onChanged: (bool? value) =>
                                    select.toggleAll(value),
                                fillColor: MaterialStateProperty.all<Color>(
                                    Colors.white)),
                            const Text(
                              "All",
                              style: TextStyle(
                                  fontFamily: "SansSerif",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      )),
                      Container(
                          width: mediaQuery.size.width * 0.06,
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: select.evenIsChecked,
                                checkColor: Colors.black,
                                onChanged: (bool? value) =>
                                    select.toggleEven(value),
                                fillColor: MaterialStateProperty.all<Color>(
                                    Colors.white)),
                            const Text(
                              "Even",
                              style: TextStyle(
                                  fontFamily: "SansSerif",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      )),
                      Container(
                        width: mediaQuery.size.width * 0.05,
                          child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                                checkColor: Colors.black,
                                value: select.oddIsChecked,
                                onChanged: (bool? value) =>
                                    select.toggleOdd(value),
                                fillColor: MaterialStateProperty.all<Color>(
                                    Colors.white)),
                            const Text(
                              "Odd",
                              style: TextStyle(
                                  fontFamily: "SansSerif",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      )),
                    ],
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: mediaQuery.size.width * 0.1,
                    height: mediaQuery.size.height * 0.05,
                    margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.yellow, width: 2.0),
                        borderRadius: BorderRadius.circular(2.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "2D - COUPON",
                            style: TextStyle(
                                fontFamily: "SansSerif",
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.yellow[600]),
                          )
                        ],
                      ),
                    )),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: mediaQuery.size.width * 0.07,
                  height: mediaQuery.size.height * 0.05,
                  margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.yellow, width: 2.0),
                      borderRadius: BorderRadius.circular(2.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: mediaQuery.size.width * 0.03,
                        height: mediaQuery.size.height * 0.05,
                        child: TextField(
                          controller: select.lpController,
                          onChanged: (v) {
                            if (v == "") {
                              select.performLP(v);
                              select.setRandomForLP();
                            } else {
                              select.performLP(v);
                            }
                          },
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter
                                .digitsOnly, // Allow only digits
                          ],
                          style: const TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontFamily: "SanSerif"),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.yellow[600],
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: mediaQuery.size.width * 0.03,
                        height: mediaQuery.size.height * 0.05,
                        alignment: Alignment.center,
                        child: const Text(
                          "LP",
                          style: TextStyle(
                              fontFamily: "SansSerif",
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    width: mediaQuery.size.width * 0.045,
                    height: mediaQuery.size.height * 0.05,
                    margin: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 0.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.yellow, width: 2.0),
                        borderRadius: BorderRadius.circular(2.0)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 2.0, 7.0, 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              checkColor: Colors.black,
                              value: select.fpIsChecked,
                              onChanged: (bool? value) =>
                                  select.toggleFP(value),
                              fillColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          const Text(
                            "FP",
                            style: TextStyle(
                                fontFamily: "SansSerif",
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
        Container(
          width: 920.0,
          margin: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 0.0),
          child: Column(
            children: [
              Row(
                children: List.generate(11, (j) {
                  if (j == 0) {
                    return SizedBox(
                        width: mediaQuery.size.width * 0.051); // to adjust the layout alignment
                  }
                  return Container(
                    margin: const EdgeInsets.fromLTRB(13, 3, 17, 3),
                    child: Button(
                      controller: widget.columnControllers[j - 1],
                    ),
                  );
                }),
              ),
              for (var i = 0; i < 10; i++) ...[
                Row(
                  children: List.generate(11, (j) {
                    if (j == 0) {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(5, 3, 6, 3),
                        child: Button(
                          controller: widget.rowControllers[i],
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.fromLTRB(0, 3, 6, 3),
                        child: Input_Box(
                          onChange: (v) {
                            if (select.fpIsChecked) {
                              int index1 = i;
                              int index2 = j - 1;
                              int calculatedIndex1 = i + 5;
                              int calculatedIndex2 = j - 1 + 5;
                              // Update the text in multiple controllers
                              select.controllers[index1][index2].text = v;
                              select.controllers[index1][calculatedIndex2]
                                  .text = v;
                              select.controllers[calculatedIndex1][index2]
                                  .text = v;
                              select
                                  .controllers[calculatedIndex1]
                                      [calculatedIndex2]
                                  .text = v;
                              select.controllers[index2][index1].text = v;
                              select.controllers[calculatedIndex2][index1]
                                  .text = v;
                              select.controllers[index2][calculatedIndex1]
                                  .text = v;
                              select
                                  .controllers[calculatedIndex2]
                                      [calculatedIndex1].text = v;
                              

                              select.controllers[index2][index1].text = v;
                              select.controllers[calculatedIndex2][index1]
                                  .text = v;
                              select.controllers[index2][calculatedIndex1]
                                  .text = v;
                              select
                                  .controllers[calculatedIndex2]
                                      [calculatedIndex1]
                                  .text = v;

                              // Set the selection after updating the text
                              select.controllers[index1][index2].selection =
                                  TextSelection.collapsed(offset: v.length);
                            }
                          },
                          text: (i * 10 + (j - 1)).toString().padLeft(2, '0'),
                          color: Colors.white,
                          controller: widget.matrixControllers[i][j - 1],
                        ),
                      );
                    }
                  }),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
