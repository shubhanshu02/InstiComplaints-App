import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'Compose.dart';
import 'package:path/path.dart' as path;
import 'dart:math';
import 'package:intl/intl.dart';
import 'Complaint_Class.dart';


class ModeratorDialog extends StatefulWidget {
  @override
  _ModeratorDialogState createState() => _ModeratorDialogState();
}

class _ModeratorDialogState extends State<ModeratorDialog> {

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
        child:Column(
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
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  'posted by ',
                  style: TextStyle(
                    fontSize: 12.0
                  ),
                ),
                Text(
                  '${complaint.email}',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromRGBO(53, 99, 184,1),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Text(
                  DateFormat('kk:mm:a').format(complaint.filingTime)+'\n'+DateFormat('dd-MM-yyyy').format(complaint.filingTime),
                  style: TextStyle(fontSize: 12.0,color: Colors.blueGrey),
                ),
                new Spacer(),
                Text(
                  complaint.category,
                  style:TextStyle(fontSize: 12.0)
                )
              ],
            ),
            SizedBox(height: 10.0,),
            Container(
              height: (4.2*MediaQuery.of(context).size.height)/10,
              width: (2.2*MediaQuery.of(context).size.width)/3,
              //margin: EdgeInsets.all(8.0),
              child: ListView(
                padding: EdgeInsets.all(8.0),
                children: <Widget>[
                  Text(complaint.description),
                  SizedBox(height: 10.0,),
                  Center(
                    child: SizedBox(
                      height: (3.9*MediaQuery.of(context).size.height)/10, // card height
                      child: PageView(
                        scrollDirection: Axis.horizontal,
                        controller: PageController(viewportFraction: 1),
                        children: complaint.images.map((imag) => Card(
                          elevation: 6.0,
                          child: Image(image: FileImage(imag),),
                          margin: EdgeInsets.all(10.0),                 
                        )
                      ).toList()
                      ),
                    )
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  child: Container(
                    //color: Color(0xFF181D3D),
                    width: (0.7*MediaQuery.of(context).size.width-30)/3,
                    height:(0.6*MediaQuery.of(context).size.height)/10,
                    decoration: BoxDecoration(
                      color: Color(0xFF181D3D),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(topLeft:Radius.circular((0.6*MediaQuery.of(context).size.height)/20),bottomLeft:Radius.circular((0.6*MediaQuery.of(context).size.height)/20),topRight:Radius.zero,bottomRight:Radius.zero),
                    ),
                    child: Center(
                      child: Text(
                        "Reject",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                VerticalDivider(color: Color.fromRGBO(58, 128, 203,1),width: 1.0,),
                Container(
                  height: (0.6*MediaQuery.of(context).size.height)/10,
                  width: (0.7*MediaQuery.of(context).size.width-30)/3,
                  decoration: BoxDecoration(
                    color: Color(0xFF181D3D),
                    shape: BoxShape.rectangle,
                    //borderRadius: BorderRadius.only(topLeft:Radius.circular((0.6*MediaQuery.of(context).size.height)/20),bottomLeft:Radius.circular((0.6*MediaQuery.of(context).size.height)/20),topRight:Radius.zero,bottomRight:Radius.zero),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        complaint.status,
                        style: TextStyle(
                          fontSize: (0.12*MediaQuery.of(context).size.width)/3,
                          color: Colors.yellow[900],
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 3.0,),
                      Text(
                        'Status',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: (0.08*MediaQuery.of(context).size.width)/3
                        ),
                      ),
                    ],
                  ),                    
                ),
                VerticalDivider(color: Color.fromRGBO(58, 128, 203,1),width: 1.0,),
                InkWell(
                  child: Container(
                    //color: Color(0xFF181D3D),
                    width: (0.7*MediaQuery.of(context).size.width-30)/3,
                    height:(0.6*MediaQuery.of(context).size.height)/10,
                    decoration: BoxDecoration(
                      color: Color(0xFF181D3D),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(topLeft:Radius.zero,bottomLeft:Radius.zero,topRight:Radius.circular((0.6*MediaQuery.of(context).size.height)/20),bottomRight:Radius.circular((0.6*MediaQuery.of(context).size.height)/20)),
                    ),
                    child: Center(
                      child: Text(
                        "Pass",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        )
      )
    );
  }
}