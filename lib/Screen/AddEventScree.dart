import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/Model/Event.dart';
import 'package:todo/Provider/EventListProvider.dart';

// For Edit or create Event in database 

class AddEventScreen extends StatelessWidget {
  final Event event;
  AddEventScreen({this.event});
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.check),
              onPressed: event != null
                  ? () => onUpdate(context)
                  : () => onSave(context)),
          Visibility(
              visible: event != null,
              child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(context))),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                style: TextStyle(fontSize: 31, fontWeight: FontWeight.bold),
                minLines: 1,
                maxLines: 2,
                controller: _titleController..text = event?.title,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 31,
                      letterSpacing: 2,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              TextField(
                minLines: 1,
                maxLines: 100,
                style: TextStyle(fontSize: 27, color: Colors.grey[400]),
                controller: _descriptionController..text = event?.description,
                cursorColor: Theme.of(context).primaryColor,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Description",
                  hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Function

  void onSave(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_titleController.text.trim().isNotEmpty ||
        _descriptionController.text.trim().isNotEmpty) {
      Event newEvent = Event(
          title: _titleController.text,
          description: _descriptionController.text);
      Provider.of<EventListProvider>(context, listen: false).addEvent(newEvent);
      Fluttertoast.showToast(msg: "Event Saved");
      Navigator.pop(context);
    }
  }

  void onDelete(BuildContext context) {
    FocusScope.of(context).unfocus();
    Provider.of<EventListProvider>(context, listen: false)
        .deleteEvent(event.id);
    Fluttertoast.showToast(msg: "Event Deleted");
    Navigator.pop(context);
  }

  void onUpdate(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_titleController.text.trim().isNotEmpty ||
        _descriptionController.text.trim().isNotEmpty) {
      if (event.title != _titleController.text ||
          event.description != _descriptionController.text) {
        Event updateEvent = Event(
            id: event.id,
            title: _titleController.text,
            description: _descriptionController.text);
        Provider.of<EventListProvider>(context, listen: false)
            .updateEvent(updateEvent);
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Event Updated");
      }
    }
  }
}
