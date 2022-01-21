import 'package:flutter/material.dart';

class BAppBar extends StatefulWidget {
  final longitude;

  final latitude;

  const BAppBar({Key? key,this.latitude, this.longitude}) : super(key: key);


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
