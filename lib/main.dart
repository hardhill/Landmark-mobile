import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:landmark/pages/add_point_page.dart';
import 'package:landmark/pages/unknown_page.dart';
import 'package:landmark/utils/theme.dart';

import 'models/db_repo.dart';
import 'models/landmark.dart';

late DbLandmark dbLandmark;
void main() {
  dbLandmark = DbLandmark();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Landmark',
      theme: basicTheme(),
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => MainPage());
        }
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.first == 'addpoint') {
          return MaterialPageRoute(builder: (context) => AddPointPage());
        }

        return MaterialPageRoute(builder: (context) => UnknownPage());
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Landmark'),
        ),
        body: ListLandmarkWidget(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(
              context,
              'addpoint',
            );
          },
          child: const Icon(Icons.add_a_photo_outlined),
        ));
  }
}

class ListLandmarkWidget extends StatefulWidget {
  const ListLandmarkWidget({Key? key}) : super(key: key);

  @override
  State<ListLandmarkWidget> createState() => _ListLandmarkWidgetState();
}

class _ListLandmarkWidgetState extends State<ListLandmarkWidget> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: _itemListLandmark,
      itemCount: 10,
    );
  }

  Widget _itemListLandmark(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: _ItemLandmark(selectedIndex == index, index),
    );
  }
}

class _ItemLandmark extends StatefulWidget {
  int index = 0;
  bool selected = false;
  late Landmark _landmark;
  _ItemLandmark(this.selected, this.index) {
    _landmark = dbLandmark.getLandmark(index);
  }

  @override
  State<_ItemLandmark> createState() => _ItemLandmarkState();
}

class _ItemLandmarkState extends State<_ItemLandmark> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.selected ? Colors.blueGrey : Colors.black45,
      child: ListTile(
        leading: Image(
            image: Image.network(widget._landmark.image).image,
            height: 80,
            fit: BoxFit.cover),
        title: Container(
            padding: EdgeInsets.only(left: 10),
            child: Text(widget._landmark.description)),
        trailing: Container(
          child: Transform.rotate(
            angle: (25 - 90) * math.pi / 180,
            child: Icon(Icons.arrow_right_alt_rounded),
          ),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white70, width: 2),
              shape: BoxShape.circle,
              color: Colors.indigo),
          height: 42,
          width: 42,
        ),
      ),
    );
  }
}
