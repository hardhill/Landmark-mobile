import 'package:flutter/material.dart';
import 'package:landmark/models/landmark.dart';

class DbLandmark {
  List<Landmark> _list = [];
  DbLandmark(){
    initDb();
  }
  void initDb(){
    _list.add(Landmark(1,'https://projects.bielecki.ru/images/points/ulan-ude.jpg','Улан-Удэ. Это типа Родина',2.3443,23.7477,540));
    _list.add(Landmark(2,'https://projects.bielecki.ru/images/points/irkutsk.jpg','Иркутск, соседний город',28.3443,107.7477,540));
    _list.add(Landmark(3,'https://projects.bielecki.ru/images/points/krasnoyarsk.jpg','Очень грязный воздух. Серо и пасмурно',32.3443,-98.7477,540));
    _list.add(Landmark(4,'https://projects.bielecki.ru/images/points/novosibirsk.jpg','В Новосибирске был летом и то не дольше чем 8 часов',27.3443,128.7477,540));
    _list.add(Landmark(5,'https://projects.bielecki.ru/images/points/omsk.jpg','В Омске видел только вокзал',37.3443,98.7477,540));
    _list.add(Landmark(6,'https://projects.bielecki.ru/images/points/perm.jpg','В Перми живет Казарбин Виталий',34.3443,90.7477,540));
    _list.add(Landmark(7,'https://projects.bielecki.ru/images/points/kazan.jpg','Казань сразу очень понравилась',15.3443,23.7477,540));
    _list.add(Landmark(8,'https://projects.bielecki.ru/images/points/ekaterinburg.jpg','Бывший Свердловск. Много лет назад была пересадка на поезд. Тогда город не впечатлил',-55.3443,123.7477,540));
    _list.add(Landmark(9,'https://projects.bielecki.ru/images/points/kostroma.jpg','Древний город Кострома',-18.3443,-28.7477,540));
    _list.add(Landmark(10,'https://projects.bielecki.ru/images/points/vladimir.jpg','Еще один древний русский город Владимир',-10.3443,18.7477,540));
  }
  Landmark getLandmark(int index){

    return _list[index];
  }

}