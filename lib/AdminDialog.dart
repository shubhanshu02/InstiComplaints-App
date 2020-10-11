import 'package:flutter/material.dart';
import 'Compose.dart';
import 'package:intl/intl.dart';

class AdminDialog extends StatefulWidget {
  @override
  _AdminDialogState createState() => _AdminDialogState();
}

class _AdminDialogState extends State<AdminDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        backgroundColor: Colors.transparent,
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    complaint.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF181D3D),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'posted by ',
                      style: TextStyle(fontSize: 12.0),
                    ),
                    Text(
                      '${complaint.email}',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color.fromRGBO(53, 99, 184, 1),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      DateFormat('kk:mm:a').format(complaint.filingTime) +
                          '\n' +
                          DateFormat('dd-MM-yyyy').format(complaint.filingTime),
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.blueGrey,
                        height: 1.0,
                      ),
                    ),
                    new Spacer(),
                    Text(complaint.category,
                        style: TextStyle(
                          fontSize: 12.0,
                          height: 1.0,
                        ))
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: (4.2 * MediaQuery.of(context).size.height) / 10,
                  //margin: EdgeInsets.all(8.0),
                  child: ListView(
                    padding: EdgeInsets.all(8.0),
                    children: <Widget>[
                      Text(complaint.description),
                      SizedBox(
                        height: 10.0,
                      ),
                      Center(
                          child: SizedBox(
                        height: (3.9 * MediaQuery.of(context).size.height) /
                            10, // card height
                        child: PageView(
                            scrollDirection: Axis.horizontal,
                            controller: PageController(viewportFraction: 1),
                            children: complaint.images
                                .map((imag) => Card(
                                      elevation: 6.0,
                                      child: Image(
                                        image: FileImage(imag),
                                      ),
                                      margin: EdgeInsets.all(10.0),
                                    ))
                                .toList()),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Status:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF181D3D),
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      complaint.status,
                      style:
                          TextStyle(fontSize: 15.0, color: Colors.yellow[900]),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        //color: Color(0xFF181D3D),
                        width:
                            (0.7 * MediaQuery.of(context).size.width - 30) / 3,
                        height: (0.6 * MediaQuery.of(context).size.height) / 10,
                        decoration: BoxDecoration(
                          color: Color(0xFF181D3D),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  (0.6 * MediaQuery.of(context).size.height) /
                                      20),
                              bottomLeft: Radius.circular(
                                  (0.6 * MediaQuery.of(context).size.height) /
                                      20),
                              topRight: Radius.zero,
                              bottomRight: Radius.zero),
                        ),
                        child: Center(
                          child: Text(
                            "Reject",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Color.fromRGBO(58, 128, 203, 1),
                      width: 1.0,
                    ),
                    InkWell(
                      child: Container(
                        //color: Color(0xFF181D3D),
                        width:
                            (0.7 * MediaQuery.of(context).size.width - 30) / 3,
                        height: (0.6 * MediaQuery.of(context).size.height) / 10,
                        decoration: BoxDecoration(
                          color: Color(0xFF181D3D),
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Text(
                            "Approve",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Color.fromRGBO(58, 128, 203, 1),
                      width: 1.0,
                    ),
                    InkWell(
                      child: Container(
                        //color: Color(0xFF181D3D),
                        width:
                            (0.7 * MediaQuery.of(context).size.width - 30) / 3,
                        height: (0.6 * MediaQuery.of(context).size.height) / 10,
                        decoration: BoxDecoration(
                          color: Color(0xFF181D3D),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              bottomLeft: Radius.zero,
                              topRight: Radius.circular(
                                  (0.6 * MediaQuery.of(context).size.height) /
                                      20),
                              bottomRight: Radius.circular(
                                  (0.6 * MediaQuery.of(context).size.height) /
                                      20)),
                        ),
                        child: Center(
                          child: Text(
                            "Solved",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            )));
  }
}
