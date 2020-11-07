import 'package:InstiComplaints/UpdateNotification.dart';
import 'package:InstiComplaints/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  String _uploadedFileURL;
  final DocumentReference _userDocument = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser.uid);

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('complaintImages/${path.basename(imageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(imageFile);
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

  File imageFile;
  bool inProcess = false;
  getImage() async {
    setState(() {
      inProcess = true;
    });
    File cropped = await ImageCropper.cropImage(
        sourcePath: imageFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.deepOrange,
          toolbarTitle: "RPS Cropper",
          statusBarColor: Colors.deepOrange.shade900,
          backgroundColor: Colors.white,
        ));

    this.setState(() {
      imageFile = cropped;
      uploadFile();
      inProcess = false;
    });
  }

  final picker = ImagePicker();
  _openGallary(BuildContext context) async {
    final picture = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(picture.path);
    });
    await getImage();
    await uploadFile();
    _userDocument.update({'profilePic': _uploadedFileURL});
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
    });
    await getImage();
    await uploadFile();
    _userDocument.update({'profilePic': _uploadedFileURL});
    Navigator.of(context).pop();
  }

  _openRemove(BuildContext context) async {
    imageFile = null;
    await _userDocument.update({'profilePic': ""});
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    final DocumentReference _userDocument = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid);
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text('Make a choice'),
              content: SingleChildScrollView(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text('Remove'),
                        Text('photo'),
                      ],
                    ),
                    onTap: () {
                      _openRemove(context);
                    },
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/gallery.png'),
                          radius: 30.0,
                        ),
                        Text('Gallery'),
                      ],
                    ),
                    onTap: () {
                      _openGallary(context);
                    },
                  ),
                  GestureDetector(
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/photo.png'),
                          radius: 30.0,
                        ),
                        Text('Camera'),
                      ],
                    ),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                ],
              )));
        });
  }

  @override
  Widget build(BuildContext context) {
    var query = MediaQuery.of(context);
    return StreamBuilder<DocumentSnapshot>(
        stream: UpdateNotification().userssnap,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return new Stack(children: <Widget>[
              Container(
                width: query.size.width / 2.5,
                height: query.size.width / 2.5,
                margin: EdgeInsets.fromLTRB(110, 0, 110, 0),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: snapshot.data.data()['profilePic'] == ""
                            ? AssetImage('assets/blankProfile.png')
                            : NetworkImage(snapshot.data.data()['profilePic']),
                        fit: BoxFit.cover)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(
                    query.size.width / 1.9, query.size.height / 6.4, 0, 0),
                child: RaisedButton(
                  onPressed: () {
                    _showChoiceDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.photo_camera,
                      color: Color(0xFF181d3d),
                      size: 35,
                    ),
                  ),
                  color: Colors.white,
                  shape: CircleBorder(),
                ),
              ),
            ]);
          } else {
            return Loading();
          }
        });
  }
}
