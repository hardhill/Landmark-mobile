import 'dart:io';
import 'package:flutter/material.dart';

class MyImageWidget extends StatefulWidget{
  late Image myImage;
  MyImageWidget({Key? key, String? isImage}) : super(key: key){
    if(isImage == null){
          myImage = Image(image: AssetImage('assets/images/nofoto.png'),fit: BoxFit.cover,);
    }else{
          myImage = Image.file(File(isImage),fit: BoxFit.cover,);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _MyImageWidgetState();
  }
}

class _MyImageWidgetState extends State<MyImageWidget>{
  @override
  Widget build(BuildContext context) {
      return widget.myImage;
    }
}

