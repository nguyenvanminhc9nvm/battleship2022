import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';


class DayData {
  DateTime dateTime;
  String dayType;
  int status;
  List<EventData> listEvent;

  DayData(this.dateTime, this.dayType, this.status, this.listEvent);
}

class EventData {
  String dateTime;
  String eventType;
  int status;
  String value;

  EventData(this.dateTime, this.eventType, this.status, this.value);
}

class EventDataToDraw {
  String dateTime;
  DrawableRoot? drawableRoot;
  int status;
  String value;

  EventDataToDraw(this.dateTime, this.drawableRoot, this.status, this.value);
}

abstract class Event {
  DrawableRoot drawableRoot;
  String eventType;

  Event(this.drawableRoot, this.eventType);
}