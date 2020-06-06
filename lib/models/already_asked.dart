import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AlreadyAskedModel with ChangeNotifier {
  var _alreadyAsked = List();

  List get alreadyAsked => _alreadyAsked;

  void add (String id) {
    _alreadyAsked.add(id);
    notifyListeners();
  }

}

/*
class AlreadyAskedModel extends InheritedModel<String> {
  var alreadyAsked = List();

  AlreadyAskedModel({this.alreadyAsked, Widget child}) : super(child:child);

  @override
  bool updateShouldNotify(AlreadyAskedModel oldWidget) {
    return listEquals(alreadyAsked, oldWidget.alreadyAsked);
  }

  @override
  bool updateShouldNotifyDependent(AlreadyAskedModel oldWidget, Set<String> dependencies) {
    return(dependencies.contains(alreadyAsked) && listEquals(alreadyAsked, oldWidget.alreadyAsked));
  }

  static AlreadyAskedModel of(BuildContext context, {String aspect}) {
    return InheritedModel.inheritFrom<AlreadyAskedModel>(context, aspect: aspect);
  }

}*/

/* TODO use inheritedmodel to have a list of already
    asked questions that all widgets (learning form mistakes
    and home can see */