import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trayning/authentification/Screen/register_medecin.dart';
import 'package:trayning/authentification/Screen/register_opticien.dart';
import 'package:trayning/authentification/Screen/register_partenaire.dart';

class Choice extends StatefulWidget {
  @override
  _ChoiceState createState() => _ChoiceState();
}
 class _ChoiceState extends State<Choice> {
   List<String> _partenaires = <String>['', 'Opticiens', 'Laboratoires', 'Assureurs', 'Medecins'];
   String _partenaire = '';

   void _onDropDownItemSelected(String newValueSelected){
     setState(() {
       this._partenaire = newValueSelected;
       switch(newValueSelected){
         case 'Opticiens' :
           Navigator.push(
             context,
             new MaterialPageRoute(
               builder: (BuildContext context) {
                 return RegisterOpticien();
               },
             ),
           );
           break;
         case "Laboratoires":
           Navigator.push(
             context,
             new MaterialPageRoute(
               builder: (BuildContext context) {
                 return new RegisterPartenaire();
               },
             ),
           );
           break;
         case 'Assureurs':
           Navigator.push(
             context,
             new MaterialPageRoute(
               builder: (BuildContext context) {
                 return new RegisterPartenaire();
               },
             ),
           );
           break;
         case 'Medecins':
           Navigator.push(
             context,
             new MaterialPageRoute(
               builder: (BuildContext context) {
                 return RegisterMedecin();
               },
             ),
           );
       }
     });
   }

  @override
  Widget build(BuildContext context) {
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
   final choix =  DropdownButtonHideUnderline(
         child: DropdownButton<String>(

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
           //state.didChange(newValueSelected);
         }
       ),
    );
   //);

    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFDADADA),
      body:  Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    logo,
                    SizedBox(height: 10.0),
                    Text("Choisir votre Partenariat",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )
                    ),
                    SizedBox(height: 50.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
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
                          choix,
                        ],
                      ),
                      //child: choix,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
 }