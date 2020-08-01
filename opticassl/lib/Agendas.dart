import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opticassl/Menu.dart';






 class Agendas extends StatefulWidget {
  Agendas({Key key}) : super(key: key);

  @override
  _AgendasState createState() => _AgendasState();
}


TextEditingController _textCosto = TextEditingController();
String id;
final db = Firestore.instance;

class _AgendasState extends State<Agendas> {


TextFormField buildTextFormFieldCosto() {

     return TextFormField(
                keyboardType: TextInputType.text,
                controller: _textCosto,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xFF009688)),
                 borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
                 ),
                 prefixIcon: Icon(Icons.remove_red_eye),
                 hintText: "Nombre",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.black,
      appBar: _getCustomAppBar(), 
      body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[

          SizedBox(height: 50.0),
          Form(
            child: buildTextFormFieldCosto(),
          ),
           SizedBox(height: 50.0),
          ButtonTheme(
                
                minWidth: 250.0,
                height: 50.0,
                child: RaisedButton(
    color: Color(0xFF009688), 
    child: Row( 
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max, 
    children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
              "Generar Cita",
              style: TextStyle(
                fontSize: 18, 
                color: Colors.white, 
              ),
          ),
        ),
        Icon(
          Icons.send, 
          color: Colors.white,
          size: 20, 
        ),
    ],
    ),
            onPressed: () {
                 createData();
                 _textCosto.text = "";
                 
            },
),
              ),
        ],
      ),
    );
  }

  void createData() async {
  String nombre;
  nombre =_textCosto.text;
        DocumentReference ref = await db.collection('Agendas').add({'Nombre': '$nombre'});
      setState(() => id = ref.documentID);  
  }

   _getCustomAppBar(){
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF009688),
            Color(0xFF011579B),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );

        }),
        Text('Agendas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.edit), onPressed: (){}),
      ],),
    ),
  );
}
}