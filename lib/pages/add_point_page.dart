import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../widgets/bottom_app_bar.dart';
import '../widgets/my_image.dart';

class AddPointPage extends StatefulWidget {
  const AddPointPage({Key? key}) : super(key: key);

  @override
  State<AddPointPage> createState() => _AddPointPageState();
}

class _AddPointPageState extends State<AddPointPage> {
  //final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  double _latitude = 0;
  double _longitude = 0;
  String _title = '';
  double halfOfScreen = 0;
  File? imageFile;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    halfOfScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add new point'),
      ),
      bottomNavigationBar: BAppBar(
        latitude: _latitude,
        longitude: _longitude,
        onPressed: () {
          getMyLocation();
        },
      ),
      body: 
        ListView(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * .6),
              child: MyImageWidget(
                isImage: imageFile?.path,
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 5, right: 2),
                        child: ElevatedButton(
                            onPressed: () {
                              imagePickup(ImageSource.camera);
                            },
                            child: Text('Photo')))),
                Expanded(
                    child: Container(
                        margin: EdgeInsets.only(left: 2, right: 5),
                        child: ElevatedButton(
                            onPressed: () {
                              imagePickup(ImageSource.gallery);
                            },
                            child: Text('Image'))))
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            ),
            Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Description'),
                ))
          ],
        ),
<<<<<<< HEAD
        
      
=======
        Positioned(
            right: 5,
            top: 5,
            child: Container(
              width: 50,
              height: 100,
              decoration: BoxDecoration(color: Colors.amber),
            )),
      ]),
>>>>>>> 9ccb0508d8562b08d657af0b626d027ed3df3c71
    );
  }

//==============================================================================
  Future<void> imagePickup(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    if (image == null) {
      return;
    }
    final imageTemporary = File(image.path);
    setState(() {
      imageFile = imageTemporary;
    });
  }

  Future<void> getMyLocation() async {
    bool serviceEnabled;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Location service is not available');
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location permission is denied');
        return;
      }
    } else if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location permission is denied forever');
      return;
    }
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 20));

      setState(() {
        _longitude = position.longitude;
        _latitude = position.latitude;
      });
    } catch (e) {
      print(e);
    }

    //Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,timeLimit: Duration(seconds: 20));

    //  _latitude = position.latitude;
    // _longitude = position.longitude;
  }
}
