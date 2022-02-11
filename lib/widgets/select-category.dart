import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SelectCategoryState();
  }
}

class _SelectCategoryState extends State<SelectCategory> {
  late List<_CategoryPoint> _categories = <_CategoryPoint>[];
  
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(items: _categories, onChanged: null);
  }

  List<_CategoryPoint> _setCategories() {
    _categories.add(_CategoryPoint(1));
    return _categories;
  }
}

class _CategoryPoint {
  var _category;

  _CategoryPoint(int this._category);
}
