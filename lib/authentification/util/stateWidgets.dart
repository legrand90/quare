import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Models/state.dart';
import '../Models/settings.dart';
import '../Models/users.dart';
import 'auth.dart';

class StateWidgets extends StatefulWidget {
  final StateModel state;
  final Widget child;

  StateWidgets({
    @required this.child,
    this.state,
});
  static _StateWidgetState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_StateDataWidget)
    as _StateDataWidget)
        .data;
  }

  @override
  _StateWidgetState createState() => new _StateWidgetState();
}

class _StateWidgetState extends State<StateWidgets> {
  StateModel state;
  //GoogleSignInAccount googleAccount;
  //final GoogleSignIn googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new StateModel(isLoading: true);
      initUser();
    }
  }

  Future<Null> initUser() async {
    //print('...initUser...');
    FirebaseUser firebaseUserAuth = await Auth.getCurrentFirebaseUser();
    Users users = await Auth.getUserLocal();
    Settings settings = await Auth.getSettingsLocal();
    setState(() {
      state.isLoading = false;
      state.firebaseUserAuth = firebaseUserAuth;
      state.users = users;
      state.settings = settings;
    });
  }

  Future<void> logOutUser() async {
    await Auth.signOut();
    FirebaseUser firebaseUserAuth = await Auth.getCurrentFirebaseUser();
    setState(() {
      state.users = null;
      state.settings = null;
      state.firebaseUserAuth = firebaseUserAuth;
    });
  }

  Future<void> logInUser(email, password) async {
    String id = await Auth.signIn(email, password);
    Users users = await Auth.getUserFirestore(id);
    await Auth.storeUserLocal(users);
    Settings settings = await Auth.getSettingsFirestore(id);
    await Auth.storeSettingsLocal(settings);
    await initUser();
  }

  @override
  Widget build(BuildContext context) {
    return new _StateDataWidget(
      data: this,
      child: widget.child,
    );
  }
}

class _StateDataWidget extends InheritedWidget {
  final _StateWidgetState data;

  _StateDataWidget({
    Key key,
    @required Widget child,
    @required this.data,
  }) : super(key: key, child: child);

  // Rebuild the widgets that inherit from this widget
  // on every rebuild of _StateDataWidget:
  @override
  bool updateShouldNotify(_StateDataWidget old) => true;
}
