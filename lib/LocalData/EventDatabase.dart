import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/LocalData/ShareManager.dart';
import 'package:todo/Model/Event.dart';

class EventDatabse {
  EventDatabse._();

  static final EventDatabse db = EventDatabse._();

  Database _database;

  final String tbName = "Event";
  final String id = "id";
  final String title = "title";
  final String description = "description";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await init();
    return _database;
  }

  init() async {
    String path = await getDatabasesPath();
    path = join(path, 'event.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE $tbName ($id INTEGER PRIMARY KEY, $title TEXT, $description TEXT);');
    });
  }

  Future<List<Event>> getEventFromDB() async {
    final db = await database;
    List<Event> eventList = [];
    List<Map<String, dynamic>> maps = await db.query(tbName, orderBy: id);
    if (maps.length > 0) {
      maps.forEach((map) {
        eventList.add(Event.fromJson(map));
      });
    }
    return eventList;
  }

  updateEventInDB(Event updateEvent) async {
    final db = await database;
    await db.update(tbName, updateEvent.toMap(),
        where: '$id = ?', whereArgs: [updateEvent.id]);
  }

  deleteEventInDB(int id) async {
    final db = await database;
    await db.delete(tbName, where: '$id = ?', whereArgs: [id]);
  }

  Future<Event> addEventInDB(Event newEvent) async {
    final db = await database;
    int id = await db.transaction((transaction) {
      return transaction.rawInsert(
          'INSERT into $tbName ($title, $description) VALUES ("${newEvent.title}", "${newEvent.description}");');
    });
    newEvent.id = id;

    return newEvent;
  }

  deleteEventDataBase() async {
    final db = await database;
    await db.delete(tbName);
    await ShareManager.logout();
  }
}
