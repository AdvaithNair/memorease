import 'package:flutter/material.dart';

//connectorclass.dart is a mediator to pass data between files and run other

class ConnectorClass {
  static final ConnectorClass _connectorClass = new ConnectorClass._internal();

  String submitText = '';
  String editText = '';
  String deleteSearcher = '';
  bool isNewCard = false;
  int counter = 0;
  final List<String> entries = <String>[];
  final newEntries = [];

  void enterText(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Enter Text"),
          content: new Text("Enter Text To Edit"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void setSnackBar(BuildContext context, String displayText) {
    final snackBar = SnackBar(
      content: Text(displayText),
      duration: const Duration(seconds: 1),
      action: SnackBarAction(
        label: 'Dismiss',
        onPressed: () {
          Scaffold.of(context).hideCurrentSnackBar();
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  factory ConnectorClass() {
    return _connectorClass;
  }
  ConnectorClass._internal();
}

final connectorClass = ConnectorClass();
