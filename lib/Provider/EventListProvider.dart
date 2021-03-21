import 'package:flutter/cupertino.dart';
import 'package:todo/LocalData/EventDatabase.dart';
import 'package:todo/Model/Event.dart';

class EventListProvider with ChangeNotifier {
  List<Event> _eventList = [];

  EventListProvider() {
    EventDatabse.db.database;
    getEventList();
  }

  getEventList() async {
    _eventList = await EventDatabse.db.getEventFromDB();
    notifyListeners();
  }

  updateEvent(Event updateEvent) async {
    await EventDatabse.db.updateEventInDB(updateEvent);
    _eventList[_eventList.indexWhere((event) => event.id == updateEvent.id)] =
        updateEvent;
    notifyListeners();
  }

  deleteEvent(int id) async {
    await EventDatabse.db.deleteEventInDB(id);
    _eventList.removeWhere((event) => event.id == id);
    notifyListeners();
  }

  addEvent(Event newEvent) async {
    final savedEvent = await EventDatabse.db.addEventInDB(newEvent);
    _eventList.add(savedEvent);
    notifyListeners();
  }

  logout() async {
    await EventDatabse.db.deleteEventDataBase();
    _eventList.clear();
    notifyListeners();
  }

  Event getEvent(int index) {
    return _eventList[index];
  }

  List<Event> get eventList => _eventList;
}
