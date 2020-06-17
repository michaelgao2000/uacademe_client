import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AlreadyAskedModel with ChangeNotifier {
  var _alreadyAsked = List();
  int startingPoint = 0;

  List get alreadyAsked => _alreadyAsked;

  void add (int id) {
    if (!alreadyAsked.contains(id)) {
      _alreadyAsked.add(id);
      _alreadyAsked.sort();
      notifyListeners();
    }
  }

  int nextQuestion () {
    for(int i = 0; i <_alreadyAsked.length - 1; i++) {
      if((_alreadyAsked[i] + 1) != (_alreadyAsked[i + 1])) {
        return _alreadyAsked[i] + 1;
      }
    }
    return(_alreadyAsked[_alreadyAsked.length-1] + 1);
  }

  bool hasAsked(int id) {
    if(_alreadyAsked.contains(id)) {
      return true;
    } else {
      return false;
    }
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
