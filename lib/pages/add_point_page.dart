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
  final _categories = <int>[1, 2, 3, 4, 5, 6];
  int? _selectedValue;
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
        actions: [
          IconButton(
            splashRadius: 20,
            color: Colors.white,
            onPressed: () {},
            icon: Icon(Icons.save_alt_outlined, color: Colors.green,),
          )
        ],
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
              // decoration: BoxDecoration(border: Border.all()),
              margin: EdgeInsets.only(left: 10, right: 10),
              child: DropdownButtonFormField(
                alignment: AlignmentDirectional.center,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none),
                value: _selectedValue,
                items: _categories.map(buildMenuItem).toList(),
                onChanged: (data) {
                  _selectedValue = data as int;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: TextFormField(
                style: TextStyle(fontSize: 20),
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Description',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepOrangeAccent),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

// =============================================================================
  DropdownMenuItem<int> buildMenuItem(int item) {
    String itemSource = "assets/images/svg/${item}.svg";
    return DropdownMenuItem(
      value: item,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: SvgPicture.asset(
              itemSource,
              height: 32,
              width: 32,
              color: Colors.white,
            ),
          ),
          TextCategorySelector(item),
        ],
      ),
    );
  }

//==============================================================================
  Widget TextCategorySelector(int value) {
    String txt = "";
    switch (value) {
      case 2:
        txt = "Rest place";
        break;
      case 3:
        txt = "Beautifuls";
        break;
      case 4:
        txt = "Interesting";
        break;
      case 5:
        txt = "Pollutions";
        break;
      case 6:
        txt = "Sports";
        break;
      default:
        txt = "Landmark";
    }
    return Text(
      txt,
      style: TextStyle(color: Colors.blueAccent),
    );
  }

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
