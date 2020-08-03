import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:OpticaSl/Inventario.dart';
import 'package:numberpicker/numberpicker.dart';


 class NuevoProducto extends StatefulWidget {
  NuevoProducto({Key key}) : super(key: key);

  @override
  _NuevoProductoState createState() => _NuevoProductoState();
}

final db = Firestore.instance;
  String id;
  String producto;
  dynamic  cantidad;
  String codigo;
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textCodigo = TextEditingController();
  TextEditingController _textCantidad = TextEditingController();
  int _currentValue = 1;


class _NuevoProductoState extends State<NuevoProducto> {

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
                 prefixIcon: Icon(Icons.add_box),
                 hintText: "Producto",
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
                 hintText: "Cantidad",
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
                 prefixIcon: Icon(Icons.code),
                 hintText: "Codigo",
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
                 Route route = MaterialPageRoute(builder: (bc) => Inventario());
                               Navigator.of(context).push(route);
                               producto = _textFieldController.text.toString();
                               cantidad = double.parse(_textCantidad.text);
                               codigo = _textCodigo.text.toString();
                               Firestore.instance.collection('Inventario').document("$producto").setData({'Nombre': '$producto', 'Cantidad': cantidad, 'Codigo': '$codigo', 'Sucursal': _currentValue});   
                               _textCantidad.text ="";
                               _textCodigo.text="";
                               _textFieldController.text="";                     
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
    MaterialPageRoute(builder: (context) => Inventario()),
    
  );

        }),
        Text('Crear Producto', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.add_box), onPressed: (){}),
      ],),
    ),
  );
}
}