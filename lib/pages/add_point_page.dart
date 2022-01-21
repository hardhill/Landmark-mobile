import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import '../widgets/bottom_app_bar.dart';

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getMyLocation();
        },
        tooltip: 'Geolocation',
        child: Icon(
          Icons.location_on_outlined,
        ),
      ),
      bottomNavigationBar: BAppBar(latitude: _latitude, longitude: _longitude),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints.loose(Size.fromHeight(halfOfScreen)),
                    child: Image(
                      image: AssetImage('assets/images/nofoto.png'),
                    ),
                  ),
                  color: Colors.white70,
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 5, right: 2),
                      child: ElevatedButton(
                          onPressed: () {getImageOrPhoto(false);}, child: Text('Photo')))),
              Expanded(
                  child: Container(
                      margin: EdgeInsets.only(left: 2, right: 5),
                      child: ElevatedButton(
                          onPressed: () {getImageOrPhoto(true);}, child: Text('Image'))))
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
         Container(
             padding:EdgeInsets.only(left: 10,right: 10),
             child: TextField(
               style: TextStyle(fontSize: 20),
               textInputAction: TextInputAction.next,
               decoration: InputDecoration(

                 hintText: 'Description'
               ),
             ))
        ],
      ),
    );
  }

//==============================================================================
  void getImageOrPhoto(bool isImage){

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
