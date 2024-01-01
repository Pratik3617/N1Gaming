// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:bet/API/AccountsDateAPI.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountsTop extends StatefulWidget {
  final Function(String date1, String date2) onDateChanged;
  AccountsTop({required this.onDateChanged});
  @override
  _Top createState() => _Top();
}

class _Top extends State<AccountsTop> {
  DateTime _dateTime1 = DateTime.now();
  DateTime _dateTime2 = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  late SharedPreferences loginData;
  String? userName;

  void initial() async {
    loginData = await SharedPreferences.getInstance();
    setState((){
        userName = loginData.getString('username');
    });
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  void _showDatePicker1() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime1 = value;
        });
      }
    });
  }

  void _showDatePicker2() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime2 = value;
        });
      }
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      String date1 = DateFormat('dd-MM-yyyy').format(_dateTime1);
      String date2 = DateFormat('dd-MM-yyyy').format(_dateTime2);
      fetchAccountDateDetails(context,userName??"",date1,date2);
      widget.onDateChanged(date1,date2);
      print('Form submitted');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Form(
        key: _formKey,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 180.0,
                          child: TextFormField(
                            readOnly: true,
                            controller: TextEditingController(
                              text: DateFormat('yyyy-MM-dd').format(_dateTime1),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Date 1',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            onTap: _showDatePicker1,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: _showDatePicker1,
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 180.0,
                          child: TextFormField(
                            readOnly: true,
                            controller: TextEditingController(
                              text: DateFormat('yyyy-MM-dd').format(_dateTime2),
                            ),
                            decoration: InputDecoration(
                              hintText: 'Date 2',
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            onTap: _showDatePicker2,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          onPressed: _showDatePicker2,
                          icon: Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20.0),
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(
                          "OK",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.purple),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "Accounts as on: ${DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now())}",
                    style: TextStyle(
                        fontFamily: "SansSerif", color: Colors.white),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(
                    "From : ${DateFormat('yyyy-MM-dd').format(_dateTime1)} To : ${DateFormat('yyyy-MM-dd').format(_dateTime2)}",
                    style: TextStyle(
                      fontFamily: "SansSerif",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
