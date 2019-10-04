import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './destination.dart';
import './connectorclass.dart';

//home.dart is the stateful home page

class HomeView extends StatefulWidget {
  const HomeView({Key key, this.destination}) : super(key: key);
  final Destination destination;

  @override
  HomePage createState() => HomePage();
}

class HomePage extends State<HomeView> {
  String currentEntry = '';

  TextEditingController _entryText = TextEditingController();

  void _submitEntry(String entry) {
    if (entry != "") {
      setState(() {
        connectorClass.submitText = entry;
        connectorClass.entries.add(entry);
        connectorClass.newEntries.add(entry);
        _entryText.clear();
        connectorClass.counter++;
        connectorClass.setSnackBar(context, "Entry Added.");
      });
    } else {
      setState(() {
        connectorClass.enterText(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0, top: 40.0),
              child: TextField(
                controller: _entryText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Remember This!',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: Text('SUBMIT'),
                onPressed: () {
                  _submitEntry(_entryText.text);
                },
              ),
            ),
          //Column(children: _entries.map((element) => ListViews()).toList(),)
          ],
        ),
      ),
    );
  }
}