import 'package:flutter/material.dart';
import '../Models/state.dart';
import 'forgot_password.dart';
import '../util/stateWidgets.dart';
import 'register_page.dart';
import '../widgets/loading.dart';
import 'login_page.dart';

class DashbordScreen extends StatefulWidget {

  @override
  _DashbordScreenState createState() => _DashbordScreenState();
}

class _DashbordScreenState extends State<DashbordScreen> {
  @override

  Widget build(BuildContext context){
      return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.red),
          home: Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              title: Text('MODE DE PAIEMENT'),
            ),
            body: Center(
              child: new Container(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    //CARD1
                    SizedBox(
                      width: 150.0,
                      height: 140.0,
                      child: new Card(
                        child: Container(
                          child: new Stack(
                            children: <Widget>[
                              new Image.asset(
                                'assets/mobile1.png',
                                width: 200.0,
                                height: 120.0,
                              ),
                            ],
                          ),
                          //   onTap{("")}
                        ),
                      ),
                    ),
                    //CARD2
                    SizedBox(
                      width: 150.0,
                      height: 140.0,
                      child: new Card(
                        child: Container(
                          child: new Stack(
                            children: <Widget>[
                              new Image.asset(
                                'assets/mobile2.jpg',
                                width: 200.0,
                                height: 120.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //CARD3
                    SizedBox(
                      width: 150.0,
                      height: 140.0,
                      child: new Card(
                        child: Container(
                          child: new Stack(
                            children: <Widget>[
                              new Image.asset(
                                'assets/mobile3.jpg',
                                width: 200.0,
                                height: 120.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ));;
    }
  }



