import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './destination.dart';
import './connectorclass.dart';
import './dialogs.dart';

//list.dart is the stateful list page
//sorry, this file is super long, I'm trying to fix that :P

class ListViews extends StatefulWidget {
  const ListViews({Key key, this.destination}) : super(key: key);

  final Destination destination;

  @override
  ListPage createState() => ListPage();
}

class ListPage extends State<ListViews> {
  TextEditingController editorText = TextEditingController();

  Dialogs _dialog = new Dialogs();

  void deleteDialog(BuildContext context, bool isDelete, int index) {
    String title;
    String body;
    String deleteButton;
    if (isDelete) {
      title = "Delete MemorE";
      body = "Do you want to delete this MemorE?";
      deleteButton = "DELETE";
    } else {
      title = "Delete All MemorEs";
      body = "Do you want to delete all MemorEs?";
      deleteButton = "DELETE ALL";
    }
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
                        if (isDelete) {
                          connectorClass.entries.removeAt(index);
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
      editorText.text = connectorClass.entries[index];
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
                      if (editorText.text != '') {
                        connectorClass.entries
                            .replaceRange(index, index + 1, [editorText.text]);
                        editorText.clear();
                        Navigator.of(context).pop();
                        //connectorClass.setSnackBar(context, "Entry Updated.");
                      } else {
                        connectorClass.enterText(context);
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
            child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: connectorClass.entries
                          .asMap()
                          .map((i, element) => MapEntry(
                              i,
                              GestureDetector(
                                  onLongPress: () {
                                    deleteDialog(context, true, i);
                                  },
                                  onTap: () {
                                    editDialog(context, i);
                                  },
                                  child: ConstrainedBox(
                                    constraints: new BoxConstraints(
                                      minWidth: 500,
                                      minHeight: 55.0,
                                    ),
                                    child: Card(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          side: BorderSide(
                                            color: Colors.grey,
                                            width: 0.5,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            element,
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                  ))))
                          .values
                          .toList(),
                      //child:
                    ),
                    RaisedButton(
                      color: Colors.red,
                      textColor: Colors.white,
                      child: Text('CLEAR'),
                      onPressed: () {
                        setState(() {
                          deleteDialog(context, false, 1);
                        });
                      },
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
