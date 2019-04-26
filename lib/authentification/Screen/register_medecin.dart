import 'dart:async';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:trayning/authentification/Models/users.dart';
import 'package:trayning/authentification/util/auth.dart';

import 'package:trayning/authentification/util/validator.dart';
import 'package:trayning/authentification/widgets/loading.dart';
import 'package:trayning/authentification/Screen/login_page.dart';

class RegisterMedecin extends StatefulWidget {

  @override
  _RegisterMedecinState createState() => new _RegisterMedecinState();
}

class _RegisterMedecinState extends State<RegisterMedecin>  with SingleTickerProviderStateMixin {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _first_name = TextEditingController();
  final TextEditingController _last_name = new TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _numero = TextEditingController();


  bool _autoValidate = false;
  bool _loadingVisible = false;

  Future <void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }
  //methode pour l'inscription
  void emailSignUp ({
    String first_name,
    String last_name,
    String password,
    String email,
    BuildContext context
  })async{
    if(_formKey.currentState.validate()){
      try{
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        await Auth.signUp(email, password).then((id) {
          Auth.addUserSettingsDB(new Users(
            id: id,
            first_name: first_name,
            last_name: last_name,
            email: email,
          ));
        });
        await Navigator.push(context,
          new MaterialPageRoute(
            builder: (BuildContext context) {
              return new LoginPage();
            },
          ),
        );
      }catch(e){
        _changeLoadingVisible();
        print("erreur de connection: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Erreur de connection",
          message: exception,
          duration: Duration(seconds: 5),
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 60.0,
          child: ClipOval(
            child: Image.asset(
              'assets/images/logo_rouge.png',
              fit: BoxFit.cover,
              width: 60.0,
              height: 60.0,
            ),
          )
      ),
    );
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
                      logo,
                      SizedBox(height: 40.0),
                      Text("S'inscrire",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      ///////////////////////////////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.black,
                              ),
                            ),
                            new Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                controller: _first_name,
                                validator: Validator.validateName,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Nom",
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),


                      ///////////////////////////////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.black,
                              ),
                            ),
                            new Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                controller: _last_name,
                                validator: Validator.validateName,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Prenom(s)",
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      ///////////////////////////////////////////////////////////////////////////
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
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
/////////////////////////////////////////////////////////////////////////
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
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.call,
                                color: Colors.black,
                              ),
                            ),
                            new Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                autofocus: false,
                                controller: _numero,
                                validator: Validator.validateNumber,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Numero de telephone",
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      ////////////////////////////////////////////////////////////////////////////
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            new Padding(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                              child: Icon(
                                Icons.lock_open,
                                color: Colors.black,
                              ),
                            ),
                            new Expanded(
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                autofocus: false,
                                controller: _password,
                                validator: Validator.validatePassword,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Mot de passe",
                                  hintStyle: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

////////////////////////////////////////////////////////////////
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
                                onPressed: (){
                                  emailSignUp(
                                      first_name: _first_name.text,
                                      last_name: _last_name.text,
                                      email: _email.text,
                                      password: _password.text,
                                      context: context);
                                },
                                child: new Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 14.0,
                                    horizontal: 14.0,
                                  ),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: Text(
                                          "Je m'inscrire",
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
                                onPressed: (){
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
                                    vertical: 14.0,
                                    horizontal: 14.0,
                                  ),
                                  child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      new Expanded(
                                        child: Text(
                                          "Je me connecte",
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          inAsyncCall: _loadingVisible),
    );
  }
}

