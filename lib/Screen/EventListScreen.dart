import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/Provider/EventListProvider.dart';
import 'package:todo/Screen/AddEventScree.dart';
import 'package:todo/Screen/LoginScreen.dart';
import 'package:todo/Widget/Event_Item.dart';

class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final eventList = Provider.of<EventListProvider>(context).eventList;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text("Events"),
        actions: [
          IconButton(
              tooltip: "Logout",
              icon: Icon(Icons.logout),
              onPressed: () => closeDialogBox(context))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: eventList.length,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            maxCrossAxisExtent: 200,
          ),
          itemBuilder: (BuildContext ctx, index) {
            return EventItem(index: index, key: ValueKey(index));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (ctx) => AddEventScreen()));
        },
      ),
    );
  }

  Future<bool> closeDialogBox(context) async {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
              title: Text(
                'Warning!',
                style: TextStyle(
                    fontSize: 21, color: Theme.of(context).primaryColor),
              ),
              content: const Text(
                  'Do you want to Logout, It will delete all the saved data'),
              actions: <Widget>[
                TextButton(
                    onPressed: () => _onLogout(context), child: Text('Yes')),
                MaterialButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'No',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ));
  }

  // Function 

 void _onLogout(BuildContext context) {
    Provider.of<EventListProvider>(context, listen: false).logout();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (ctx) => LoginScreen()), (route) => false);

    Fluttertoast.showToast(msg: "Signed out");
  }
}
