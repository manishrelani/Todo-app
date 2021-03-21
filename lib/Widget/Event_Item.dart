import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/EventListProvider.dart';
import 'package:todo/Screen/AddEventScree.dart';

// A single item (preview of a Event) in the EventList.
class EventItem extends StatelessWidget {
  final int index;
  EventItem({@required this.index, Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final event = Provider.of<EventListProvider>(context).getEvent(index);
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              event.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 14),
            Flexible(
              flex: 1,
              child: Text(
                event.description,
                style: TextStyle(fontSize: 17, color: Colors.grey[200]),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => AddEventScreen(
                      event: event,
                    )));
      },
    );
  }
}
