import 'package:client/models/already_asked.dart';
import 'package:flutter/material.dart';

class AlreadyAskedManagerWidget extends StatefulWidget {
  final Widget child;

  AlreadyAskedManagerWidget({Key key, this.child}) : assert(child != null),
        super(key : key);

  @override
  _AlreadyAskedManagerWidgetState createState() => _AlreadyAskedManagerWidgetState();
}

class _AlreadyAskedManagerWidgetState extends State<AlreadyAskedManagerWidget> {
  var alreadyAsked;

  void initState() {
    super.initState();
    alreadyAsked = List();
  }

  void addQuestion(String id) {
    setState(() => alreadyAsked.add(id));
  }

  @override
  Widget build(BuildContext context) {
    /*return AlreadyAskedModel(
      alreadyAsked: alreadyAsked,
      child: widget.child
    );*/
    return null;
  }
}


