import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './destination.dart';
import './connectorclass.dart';
import './dialogs.dart';

//list.dart is the stateful list page
//sorry, this file is super long, I'm trying to fix that eek

class ListViews extends StatefulWidget {
  const ListViews({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  ListPage createState() => ListPage();
}

class ListPage extends State<ListViews> {
  TextEditingController editorText = TextEditingController();

  Dialogs _dialog = new Dialogs();
  void deleteDialog(
      BuildContext context, String title, String body, String deleteButton, /*String searcher*/) {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text(title),
              content: new Text(body),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("CANCEL"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                    child: new Text(
                      deleteButton,
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      //DELETION CODE HERE
                      setState(() {
                        if (deleteButton == "DELETE") {
                          connectorClass.entries.removeLast(/*searcher*/); //change to remove
                        } else {
                          connectorClass.entries.clear();
                        }
                        Navigator.of(context).pop();
                      });
                    }),
              ],
            );
          });
    });
  }

  void editDialog(BuildContext context, int index) {
    setState(() {
      editorText.text = connectorClass.submitText;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            title: new Text("Edit MemorE"),
            content: TextField(
              controller: editorText,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Edit',
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("CANCEL"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text("CLEAR"),
                onPressed: () {
                  editorText.text = "";
                },
              ),
              new FlatButton(
                  child: new Text(
                    "SAVE",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      print(connectorClass.entries[index]);
                      if (editorText.text != '') {
                        connectorClass.entries.add(editorText.text);//EDIT
                        editorText.clear();
                        connectorClass.counter--;
                        Navigator.of(context).pop();
                        //connectorClass.setSnackBar(context, "Entry Updated.");
                      } else {
                        connectorClass.enterText(context);
                        connectorClass.counter = 0;
                      }
                    });
                  }),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Center(
              child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ConstrainedBox(
                    constraints: new BoxConstraints(
                      minWidth: 500,
                      minHeight: 55.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                            onLongPress: () {
                              deleteDialog(
                                  context,
                                  "Delete MemorE",
                                  "Do you want to delete this MemorE?",
                                  "DELETE");
                            },
                            onTap: () {
                              editDialog(context, 2);
                            },
                            //child: 
                            ),
                        RaisedButton(
                          color: Colors.red,
                          textColor: Colors.white,
                          child: Text('CLEAR'),
                          onPressed: () {
                            setState(() {
                              deleteDialog(
                                  context,
                                  "Delete All MemorEs",
                                  "Do you want to delete all MemorEs?",
                                  "DELETE ALL");
                            });
                          },
                        )
                      ],
                    )),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
