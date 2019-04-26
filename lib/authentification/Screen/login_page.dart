import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import '../util/stateWidgets.dart';
import '../Screen/dashbord.dart';
import '../Screen/forgot_password.dart';
import '../Screen/register_page.dart';
import '../util/auth.dart';
import '../util/validator.dart';
import '../widgets/loading.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //final TextEditingController _email = TextEditingController();
  //final TextEditingController _password = TextEditingController();

  String _email;
  String _password;

  bool _autoValidate = false;
  bool _loadingVisible = false;

  Future <void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  Widget build(BuildContext context){
    final logo = Hero(
      tag: 'logo',
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
          )),
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
                      Text("Se connecter",
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
                                //controller: _email,
                                validator: (value) => value.isEmpty ? 'invalide email' : null,
                                onSaved: (value) => _email = value,
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
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal:20.0),
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
                                //controller: _password,
                                validator: (value) => value.isEmpty ? 'invalide password' : null,
                                onSaved: (value) => _password = value,
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
                                  _emailLogin();
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
                                          "Se connecter",
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
                                  padding: const EdgeInsets.only(left: 20.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Mot de passe oublie",
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
                                        return new ForgotPasswordScreen();
                                      },
                                    ),
                                  );
                                },
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
                                color: Colors.black,
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    new MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return new RegisterPage();
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
                                          "Creer un compte",
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

  Future<void> smsError(String error) async{
    Text titre = new Text("Error:");
    Text soustitre = new Text(error);
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext){
        return new AlertDialog(title: titre, content: soustitre, actions: <Widget>[okButton(buildContext)],);
      }
    );
}

FlatButton okButton(BuildContext context){
    return new FlatButton(onPressed: ()=> Navigator.of(context).pop(), child: new Text("ok"));
}
  //methode pour se connecter
  bool validateAndSave(){
    final form = _formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    return false;
  }
  void _emailLogin ()async{
    if(validateAndSave()){
      try{
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        //await _changeLoadingVisible();
        //await StateWidgets.of(context).logInUser(email, password);
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        await Navigator.push(context,
           new MaterialPageRoute(
              builder: (BuildContext context){
                return new DashbordScreen();
              }
          ),
        );
        //Navigator.of(context).pushNamed(DashbordScreen.tag);
        //Navigator.push(context, MaterialPageRoute(builder: (context) => DashbordScreen()));
        //print('sign in: ${user.uid}');

      }catch(e){
       // print('sign in: $e');
        smsError("vous n'etes pas un membre");
        /*
        await Navigator.push(context,
          new MaterialPageRoute(
              builder: (BuildContext context){
                return new LoginPage();
              }

          ),
        );*/
        /*
        _changeLoadingVisible();
        print("Erreur de connection: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Erreur de connection",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
        */
      }
    }else{
      setState(() {
        _autoValidate = true;
      }
      );

    }
  }

}

