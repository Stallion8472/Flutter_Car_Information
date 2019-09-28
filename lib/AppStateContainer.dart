import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'model/AppState.dart';

class AppStateContainer extends StatefulWidget {
  final AppState state;
  final Widget child;

  AppStateContainer({
    @required this.child,
    this.state,
  });

  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  _AppStateContainerState createState() => new _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  AppState state;

  @override
  void initState() {
    super.initState();
    loadAppStateFromJSON();
  }

  @override
  void dispose() {
    writeAppStateToJSON(state);
    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/AppState.json');
  }

  Future<File> writeAppStateToJSON(AppState appState) async {
    final file = await _localFile;
    return file.writeAsString(jsonEncode(
        {"user": appState.loggedInUser, "vehicle": appState.selectedVehicle}));
  }

  loadAppStateFromJSON() async {
    final file = await _localFile;
    var fileExists = await file.exists();
    if (fileExists) {
      setState(() {
        state = AppState.fromJson(jsonDecode(file.readAsStringSync()));
      });
    }
  }

  void updateState(AppState appState) {
    if (state != appState) {
      setState(() {
        state = appState;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
