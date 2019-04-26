import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:trayning/authentification/Models/users.dart';
import 'package:trayning/authentification/Screen/register_page.dart';
import 'package:trayning/authentification/util/auth.dart';
import 'package:trayning/authentification/util/validator.dart';
import 'package:trayning/authentification/widgets/loading.dart';
import 'package:trayning/authentification/routes/route.dart';
import 'package:trayning/authentification/Screen/login_page.dart';

class RegisterPartenaire extends StatefulWidget {
  @override
  _RegisterPartenaire createState() => new _RegisterPartenaire();
}

class _RegisterPartenaire extends State<RegisterPartenaire> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _first_name = TextEditingController();
  final TextEditingController itemControlled = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController numero = TextEditingController();

  //les valeurs du combo

  List<String> _partenaires = <String>['', 'Opticiens', 'Laboratoires', 'Assureurs', 'Medecins'];
  String _partenaire = '';
  //var _currencies = ['Officines', 'Laboratoires', 'Assureurs', 'Medecins', 'Opticiens'];
  //var _currentItemSelected = 'Officines';

  bool _autoValidate = false;
  bool _loadingVisible = false;

  Future <void> _changeLoadingVisible() async {
    setState(() {
      _loadingVisible = !_loadingVisible;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
           logo  ,
              SizedBox(height: 10.0),
              Text("Inscription partenaire",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  )
              ),
              SizedBox(height: 10.0),
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
                          hintText: "Mon de la Compagnie",
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
                          controller: numero,
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
 ////////////////////////////////////////////////////////////////////
            /*  Padding(
                  padding: const EdgeInsets.only(left: 40.0),
                ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                        //width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                          child: Icon(
                            Icons.group,
                            color: Colors.black,
                          ),
                        ),
                        new Expanded(
                          child: FormField(
                              validator: Validator.validateCombo,
                              builder: (FormFieldState<String> state) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    //icon: const Icon(Icons.color_lens),
                                    hintText: 'type de partenariat',
                                    errorText: state.hasError ? state.errorText : null,
                                  ),
                                  isEmpty: _partenaire== '',
                                  //child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        iconSize: 30.0,
                                        value: _partenaire,
                                        isDense: true,
                                        items: _partenaires.map((String value){
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String newValueSelected){
                                          //un element de dropdown est choisi
                                          _onDropDownItemSelected(newValueSelected);
                                          state.didChange(newValueSelected);
                                        }
                                    ),
                                  //),
                                );
                              }
                          ),
                        )
                      ],
                    ),
                  ),*/
////////////////////////////////////////////////////////////////
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
                          _emailRegister(
                              firstName: _first_name.text,
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
                                  "Je m'abonne",
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
                            "Vous avez deja un compte, Connectez-vous ?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.black,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
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

  void _onDropDownItemSelected(String newValueSelected){
      setState(() {
        this._partenaire= newValueSelected;
      });
  }

  void _emailRegister(
      {String firstName,
        String email,
        String password,
        BuildContext context
      }) async {
    if (_formKey.currentState.validate()) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        await _changeLoadingVisible();
        //need await so it has chance to go through error if found.
        await Auth.signUp(email, password).then((id) {
          Auth.addUserSettingsDB(new Users(
            id: id,
            email: email,
            first_name: firstName,
          ));
        });
        await Navigator.push(context, new MaterialPageRoute(builder:
            (BuildContext context) {return new LoginPage();},
        ),
        );
      } catch (e) {
        _changeLoadingVisible();
        print("Erreur de connection: $e");
        String exception = Auth.getExceptionText(e);
        Flushbar(
          title: "Erreur de connection",
          message: exception,
          duration: Duration(seconds: 5),
        )..show(context);
      }
    } else {
      setState(() => _autoValidate = true,
      );
    }
  }

}

