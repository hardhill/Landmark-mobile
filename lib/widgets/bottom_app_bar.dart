import 'package:flutter/material.dart';

class BAppBar extends StatefulWidget {
  final longitude;

  final latitude;
  final VoidCallback? onPressed;
  const BAppBar({Key? key,this.latitude, this.longitude, this.onPressed}) : super(key: key);


  @override
  State<BAppBar> createState() => _BAppBarState();
}

class _BAppBarState extends State<BAppBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 10,
      // color: Colors.blueGrey,
      child: Container(
        height: 60,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              child:Text(widget.latitude.toString())
            ),
            IconButton(onPressed: widget.onPressed, icon: Icon(Icons.location_on_outlined)),
            Container(
              child: Text(widget.longitude.toString()),
            )
          ],
        ),
      ),
      shape: CircularNotchedRectangle(),
    );
  }
}
