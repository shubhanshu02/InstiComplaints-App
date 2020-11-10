import 'dart:io';
import 'package:InstiComplaints/ComplaintFiling.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'DropDown.dart';
import 'package:path/path.dart' as path;
import 'dart:math';
import 'Complaint_Class.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

MailContent complaint;
String selectedCategory;
final formKey1 = GlobalKey<FormState>();

class BackgroundMaker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: (4.3 * MediaQuery.of(context).size.width) / 8,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            /*Container(
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              //child: Compose(),
            ),
            Container(
                 height: MediaQuery.of(context).size.height * 0.035,
                 color: Color(0xFF181D3D),
               ),*/
            ClipPath(
                clipper: CurveClipper(),
                child: Container(
                  constraints: BoxConstraints.expand(),
                  color: Color(0xFF181D3D),
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 25.0, 0.0, 0.0),
                      child: Row(
                        children: <Widget>[
                          SizedBox(height: 30.0),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/app_logo_final_jpg_ws.jpg'),
                            radius: (32 * MediaQuery.of(context).size.height) /
                                1000,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'InstiComplaint',
                            style: TextStyle(
                                fontFamily: 'Amaranth',
                                color: Colors.white,
                                fontSize:
                                    (30 * MediaQuery.of(context).size.height) /
                                        1000),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 28),
                    Text('File a Complaint',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize:
                                (30 * MediaQuery.of(context).size.height) /
                                    1000)),
                    //SizedBox(height: MediaQuery.of(context).size.height / 12),
                  ]),
                )),
          ],
        ));
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      // set the "current point"
      ..lineTo(0, size.width / 8)
      ..addArc(
          Rect.fromLTWH(0, size.width / 512 - size.width / 8, size.width / 2,
              size.width / 2),
          pi,
          -pi / 2)
      ..lineTo(4 * size.width / 4, size.width / 2 - size.width / 8)
      ..addArc(
          Rect.fromLTWH(2 * size.width / 4, size.width / 2 - size.width / 8,
              size.width / 2, size.width / 2),
          3.14 + 1.57,
          1.57)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..lineTo(0, size.width / 8);
    return path;
  }

  @override
  bool shouldReclip(oldCliper) => false;
}

class ImageShow extends StatelessWidget {
  final String name;
  final Function delete;
  ImageShow({this.name, this.delete});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (3.5 * MediaQuery.of(context).size.width) / 6,
      margin: EdgeInsets.symmetric(vertical: 5.0),
      padding: EdgeInsets.only(left: 5.0),
      color: Colors.grey[300],
      child: Row(
        children: <Widget>[
          Icon(Icons.image),
          SizedBox(
            width: 3.0,
          ),
          /*Text(name.length > 18
              ? name.substring(0, 6) + '...' + name.substring(name.length - 5)
              : name),*/
          Text(name),
          //SizedBox(width: 3.0,),
          new Spacer(),
          IconButton(
            padding: EdgeInsets.only(right: 2.0),
            onPressed: delete,
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}

class Compose extends StatefulWidget {
  @override
  _ComposeState createState() => _ComposeState();
}

class _ComposeState extends State<Compose> {
  void initState() {
    super.initState();
    _dropdownMenuItems = buildDropDownMenuItems(categories);
    //selectedItem = _dropdownMenuItems[0].value;
  }

  List<DropdownMenuItem<String>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<String>> items = List();
    for (String listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem),
          value: listItem,
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<String>> _dropdownMenuItems;
  File _image;
  String _uploadedFileURL;

  List<String> imagesInComplaint = [];

  Future<void> _pickImage(ImageSource source) async {
    await ImagePicker.pickImage(source: source).then((image) {
      setState(() {
        _image = image;
      });
    });

    /*setState(() {
      if (selected != null) {
        imagesInComplaint.add(selected);
      }
      print(
          imagesInComplaint.length.toString() + '\n\n\n' + selected.toString());
    });*/
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('complaintImages/${path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    await storageReference.getDownloadURL().then((fileURL) {
      //print(fileURL);
      setState(() {
        //print(fileURL);
        _uploadedFileURL = fileURL;
        //print(_uploadedFileURL);
      });
    });
  }

  String title = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF181D3D),
      child: SafeArea(
        child: Scaffold(
            /*appBar: AppBar(
        backgroundColor: Color.fromRGBO(24, 29, 61,1),

            ),*/
            body: Form(
          key: formKey1,
          child: ListView(
            children: <Widget>[
              BackgroundMaker(),
              Card(
                //shadowColor: Color.fromRGBO(24, 29, 61,1),
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                elevation: 10.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //CategoryDropdown(),
                    Container(
                      //width: 0.65*MediaQuery.of(context).size.width,
                      height: 75.0,
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: DropdownButtonFormField<String>(
                            //key: formKey1,
                            hint: Container(
                              padding: EdgeInsets.symmetric(horizontal: 11),
                              child: Text(
                                'Category',
                                style: TextStyle(
                                    color: Color.fromRGBO(24, 51, 98, 1),
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            validator: (value) => value == null
                                ? "Please select a category"
                                : null,
                            isExpanded: true,
                            elevation: 10,
                            value: selectedCategory,
                            items: _dropdownMenuItems,
                            onChanged: (value) {
                              setState(() {
                                selectedCategory = value;
                              });
                            }),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 400.0,
                      constraints: BoxConstraints(
                        maxHeight: 200.0,
                        minHeight: 80.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.5),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Title can't be left empty.";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              title = value;
                            });
                          },
                          //controller: titleController,
                          minLines: 1,
                          maxLines: 3,
                          maxLength: 80,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            height: 2.0,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Title:  ',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(24, 51, 98, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      width: 400.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.8),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Description can't be left empty.";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              description = value;
                            });
                          },
                          //controller: descripController,
                          minLines: 1,
                          maxLines: 12,
                          maxLength: 350,
                          textAlignVertical: TextAlignVertical.center,
                          style: TextStyle(
                            height: 2.0,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Description:  ',
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                                color: Color.fromRGBO(24, 51, 98, 1),
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        IconButton(
                          alignment: Alignment.centerLeft,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Color.fromRGBO(24, 29, 61, 1),
                            size: 40.0,
                          ),
                          color: Colors.blue,
                          onPressed: () async {
                            await _pickImage(ImageSource.gallery);
                            if (_image != null) {
                              await uploadFile();
                              setState(() {
                                imagesInComplaint.add(_uploadedFileURL);
                                //print(_uploadedFileURL);
                                //print(imagesInComplaint);
                              });
                            }
                          },
                        ),
                        Text(
                          ':   ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 30.0),
                        ),
                        Column(
                          children: imagesInComplaint
                              .map((imag) => ImageShow(
                                  name:
                                      'Uploaded Image ${imagesInComplaint.indexOf(imag)}',
                                  delete: () {
                                    setState(() {
                                      imagesInComplaint.remove(imag);
                                    });
                                  }))
                              .toList(),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: RaisedButton(
                  onPressed: () async {
                    if (formKey1.currentState.validate()) {
                      print(formKey1.currentState.validate().toString());
                      complaint = MailContent(
                          title: title,
                          category: selectedCategory,
                          description: description,
                          images: imagesInComplaint,
                          filingTime: DateTime.now(),
                          status: status[0],
                          upvotes: [],
                          uid: FirebaseAuth.instance.currentUser.uid,
                          email: FirebaseAuth.instance.currentUser.email);
                      /*await Future.delayed(Duration(seconds: 2),(){
                          
                        });*/
                      //TODO: Add mail to database.
                      title = '';
                      description = '';
                      selectedCategory = null;

                      await ComplaintFiling().fileComplaint(
                          complaint.title,
                          complaint.category,
                          complaint.description,
                          complaint.images,
                          complaint.filingTime,
                          complaint.status,
                          complaint.upvotes,
                          complaint.uid,
                          complaint.email);
                      imagesInComplaint.clear();

                      /*showDialog(
                              context: context,
                              builder: (BuildContext context) => AdminDialog('SCvnnfBP66JpkhBK12do')
                            );*/

                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                child: Container(
                                  child: Center(
                                    child: Text('Complaint Filed'),
                                  ),
                                  //color: Color.fromRGBO(24, 29, 61,1),
                                  height: 50.0,
                                  width: 70.0,
                                ),
                              ));
                    } else {
                      print('yes');
                    }
                  },
                  child: Text(
                    'Submit',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  color: Color(0xFF181D3D),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Image(image: AssetImage('assets/app_logo_final0.png')),
                height: 120.0,
                width: 120.0,
              )
            ],
          ),
        )),
      ),
    );
  }
}
