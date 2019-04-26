import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/services.dart';
import 'login_page.dart';
import 'register_page.dart';

import '../util/auth.dart';
import '../util/validator.dart';
import '../widgets/loading.dart';

class ForgotPasswordScreen extends StatefulWidget {
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = new TextEditingController();


  bool _autoValidate = false;
  bool _loadingVisible = false;

  Future <void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  //methode pour se connecter
  void forgotPassword ({
    String email,
    BuildContext context
  })async{
    if(_formKey.currentState.validate()){
      try{
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        await Auth.forgotPasswordEmail(email);
          await _changeLoadingVisible();
          Flushbar(
            title: "Annuler l'envoi du mot de passe",
            message: "Verifier votre mail et suiver les instructions pour reinitialiser le mot de passe",
            duration: Duration(seconds: 20),
          )..show(context);
      }catch(e){
        _changeLoadingVisible();
        print("erreur de mot de passe oublie: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "erreur de mot de passe oublie",
          message: exception,
          duration: Duration(seconds: 10),
        )..show(context);
      }
    }else{
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFDADADA),
      body: LoadingScreen(
      child: Form(
        key: _formKey,
        autovalidate: _autoValidate,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                imageAsset(),
                SizedBox(height: 20.0),
                Text("Reinitialiser le mot de passe",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    )
                ),
                SizedBox(height: 50.0),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Row(
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        child: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                      ),
                      new Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          autofocus: false,
                          controller: _email,
                          validator: Validator.validateEmail,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
 ////////////////////////////////////////////////////////////////////////////////////
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)
                          ),
                          color: Colors.black,
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return new LoginPage();
                                },
                              ),
                            );
                          },
                          child: new Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: Text(
                                    "Changer de mot de passe",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      //fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //////////////////////////////////////////////////////////
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      new Expanded(
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)
                          ),
                          color: Colors.black26,
                          child: new Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 15.0,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Se connecter",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                                //fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return new LoginPage();
                                },
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            ),
          ),
        ),
        ),
        inAsyncCall: _loadingVisible,
      ),
      );
  }

  Widget imageAsset() {
    AssetImage assetImage = AssetImage('assets/images/logo_rouge.png');
    Image image = Image(image: assetImage,
      width: 60.0,
      height: 60.0,
    );
    return Container(
      child: image,
    );
  }
}