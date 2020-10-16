import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';

class Camera extends StatefulWidget {
  @override
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
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
      inProcess = false;
    });
  }

  final picker = ImagePicker();
  _openGallary(BuildContext context) async {
    final picture = await picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(picture.path);
    });
    getImage();
    Navigator.of(context).pop();
  }

  _openCamera(BuildContext context) async {
    var picture = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = File(picture.path);
    });
    getImage();
    Navigator.of(context).pop();
  }

  _openRemove(BuildContext context) async {
    imageFile = null;
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context) {
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
    return new Stack(children: <Widget>[
      Container(
        width: 160,
        height: 160,
        margin: EdgeInsets.fromLTRB(110, 0, 110, 0),
        decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: imageFile == null
                    ? NetworkImage('${FirebaseAuth.instance.currentUser.photoURL}')
                    : FileImage(imageFile),
                fit: BoxFit.cover)),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(210, 110, 0, 0),
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
  }
}
