import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      body: Form(
        child: ListView(
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
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              height: 52,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(

                      child: SvgPicture.asset("assets/images/svg/1.svg"),
                      width: 48,
                    ),
                    Container(
                      child: SvgPicture.asset("assets/images/svg/2.svg"),
                      width: 48,
                    ),
                    Container(
                      child: SvgPicture.asset("assets/images/svg/3.svg"),
                      width: 48,
                    ),
                    Container(
                      child: SvgPicture.asset("assets/images/svg/4.svg"),
                      width: 48,
                    ),
                    Container(
                      child: SvgPicture.asset("assets/images/svg/5.svg"),
                      width: 48,
                    ),
                    Container(
                      child: SvgPicture.asset("assets/images/svg/6.svg"),
                      width: 48,
                    ),
                  ],

              ),
            ),
            Container(
                // padding: EdgeInsets.only(left: 10, right: 10),
                child: TextFormField(
                  style: TextStyle(fontSize: 20),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(hintText: 'Description'),
                ))
          ],
        ),
      ),
    );
  }

// =============================================================================


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

class _Category {
  String? categoryName;

  _Category(this.categoryName);
  @override
  String toString() {
    // TODO: implement toString
    return super.toString();
  }
}
