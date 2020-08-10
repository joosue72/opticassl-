import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:OpticaSl/HistorialCobranzas.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';



 class Cobranza extends StatefulWidget {
  Cobranza({Key key}) : super(key: key);

  @override
  _CobranzaState createState() => _CobranzaState();
}

final db = Firestore.instance;
  String id;
  String producto;
  dynamic  cantidad;
  dynamic codigo;
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textCodigo = TextEditingController();
  TextEditingController _textCantidad = TextEditingController();
  int _currentValue = 1;

class _CobranzaState extends State<Cobranza> {

  TextFormField buildTextFormFieldNombre() {
  
    return TextFormField(
                keyboardType: TextInputType.text,
                controller: _textFieldController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xFF009688)),
                 borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
                 ),
                 prefixIcon: Icon(Icons.note),
                 hintText: "Numero De Nota",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            );
  }

  TextFormField buildTextFormFieldCantidad() {
  
    return TextFormField(
                keyboardType: TextInputType.text,
                controller: _textCantidad,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xFF009688)),
                 borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
                 ),
                 prefixIcon: Icon(Icons.storage),
                 hintText: "Cantidad De Notas",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            );
  }

  TextFormField buildTextFormFieldCodigo() {
  
    return TextFormField(
                keyboardType: TextInputType.text,
                controller: _textCodigo,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xFF009688)),
                 borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
                 ),
                 prefixIcon: Icon(Icons.attach_money),
                 hintText: "Total",
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

          SizedBox(height: 100.0),
          Form(
            
            //key: _riKey1,
            child: buildTextFormFieldNombre(),
          ),
          SizedBox(height: 20.0,),
          Form(
            child: buildTextFormFieldCantidad(),
          ),
          SizedBox(height: 20.0,),
          Form(
            child: buildTextFormFieldCodigo(),
          ),
          SizedBox(height: 20.0,),
          Form(
            
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new NumberPicker.integer(
                
                initialValue: _currentValue,
                minValue: 1,
                maxValue: 10,
                onChanged: (newValue) =>
                    setState(() => _currentValue = newValue)),
            new Text("Sucursal: $_currentValue",style: TextStyle(color: Colors.white),),
          ],
        ),
      
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
              "Crear",
              style: TextStyle(
                fontSize: 18, 
                color: Colors.white, 
              ),
          ),
        ),
        Icon(
          Icons.create_new_folder, 
          color: Colors.white,
          size: 20, 
        ),
    ],
    ),
            onPressed: () {
                crateData();                                
            },
),
              ),
        
        ],
        
      ),
      
    );
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
    MaterialPageRoute(builder: (context) => HistorialCobranzas()),
    
  );

        }),
        Text('Nueva Cobranza', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.add_box), onPressed: (){}),
      ],),
    ),
  );
}

void crateData() async
{
      DateTime now = DateTime.now();
      String mes = DateFormat('MMM').format(now);
      String dia = DateFormat('d').format(now);
      int numerofecha;
      switch(mes)
      {
        case 'Jan':
            numerofecha = 1;
        break;
        case 'Feb':
            numerofecha = 2;
        break;
        case 'Mar':
            numerofecha = 3;
        break;
        case 'Apr':
            numerofecha = 4;
        break;
        case 'May':
            numerofecha = 5;
        break;
        case 'Jun':
            numerofecha = 6;
        break;
        case 'Jul':
            numerofecha = 7;
        break;
        case 'Aug':
            numerofecha = 8;
        break;
        case 'Sep':
            numerofecha = 9;
        break;
        case 'Oct':
            numerofecha = 10;
        break;
        case 'Nov':
            numerofecha = 11;
        break;
        case 'Dec':
            numerofecha = 12;
        break;
      }


  
                               producto = _textFieldController.text.toString();
                               cantidad = double.parse(_textCantidad.text);
                               codigo = double.parse(_textCodigo.text);
                               Firestore.instance.collection('Cobranza').add({'NumeroNota': '$producto', 'CantidadNotas': cantidad, 'TotalCobranza': codigo, 'Sucursal': _currentValue, 'Dia': int.parse(dia), 'Mes': numerofecha});   
                               _textCantidad.text ="";
                               _textCodigo.text="";
                               _textFieldController.text="";
}

}