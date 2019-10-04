import 'package:flutter/material.dart';
import './connectorclass.dart';

class DialogFunctions extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class Dialogs extends State<DialogFunctions> {
  void deleteDialog(BuildContext context) {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("Delete MemorE"),
              content: new Text("Do you want to delete this MemorE?"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                    child: new Text(
                      "DELETE",
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      //DELETION CODE HERE
                      setState(() {
                        connectorClass.entries.removeLast();
                        Navigator.of(context).pop();
                      });
                    }),
              ],
            );
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}