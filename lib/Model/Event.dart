import 'package:flutter/foundation.dart';

class Event {
  int id;
  String title;
  String description;

  Event({this.id, @required this.description, @required this.title});

  factory Event.fromJson(var json) {
    return Event(
        id: json["id"], description: json["description"], title: json["title"]);
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map();
    map["id"] = this.id;
    map["title"] = this.title;
    map["description"] = this.description;
    return map;
  }
}
