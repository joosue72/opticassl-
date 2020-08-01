import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opticassl/Inventario.dart';
import 'package:opticassl/NuevoProducto.dart';
import 'package:opticassl/Ventas.dart';



 class EditarInventario extends StatefulWidget {
  EditarInventario({Key key}) : super(key: key);

  @override
  _EditarInventarioState createState() => _EditarInventarioState();
}

TextEditingController _textCosto = TextEditingController();
TextEditingController _textCodigo = TextEditingController();
String id;
final db = Firestore.instance;
var selectedCurrency, selectedType;


class _EditarInventarioState extends State<EditarInventario> {

  TextFormField buildTextFormFieldCosto(DocumentSnapshot doc) {

     return TextFormField(
                keyboardType: TextInputType.number,
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
                 prefixText: "${doc.data['Nombre']}",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            );
  }
  TextFormField buildTextFormFieldCantidad(DocumentSnapshot doc) {

     return TextFormField(
                keyboardType: TextInputType.number,
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
                 prefixIcon: Icon(Icons.storage),
                 hintText: "${doc.data['Cantidad']}",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            );
  }
  TextFormField buildTextFormFieldCodigo(DocumentSnapshot doc) {

     return TextFormField(
                keyboardType: TextInputType.number,
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
                 hintText: "${doc.data['Codigo']}",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            );
  }

  
  
  Card crearCarta(DocumentSnapshot doc)
  {
    return Card(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    color: Colors.black,
    child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
        children: <Widget>[
           Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("${doc.data['Nombre']}",
            style: TextStyle(color: Colors.white, fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
           SizedBox(height: 10.0,),
           Form(child: buildTextFormFieldCantidad(doc)),
           SizedBox(height: 10.0,),
           Form(child: buildTextFormFieldCodigo(doc)),
           SizedBox(height: 15.0,),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              
              ButtonTheme(
                
                minWidth: 120.0,
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
              "Guardar",
              style: TextStyle(
                fontSize: 18, 
                color: Colors.white, 
              ),
          ),
        ),
        Icon(
          Icons.save, 
          color: Colors.white,
          size: 18, 
        ),
    ],
    ),
            onPressed: () {
                 //Route route = MaterialPageRoute(builder: (bc) => VentasPendientes());
                               //Navigator.of(context).push(route);
                               updateCantidad(doc);
                                          
            },
),
              ),
              SizedBox(width: 10.0,),
               ButtonTheme(
                
                minWidth: 120.0,
                height: 50.0,
                child: RaisedButton(
    color: Color(0xFFF44336), 
    child: Row( 
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max, 
    children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
              "Borrar",
              style: TextStyle(
                fontSize: 18, 
                color: Colors.white, 
              ),
          ),
        ),
        Icon(
          Icons.delete, 
          color: Colors.white,
          size: 18, 
        ),
    ],
    ),
            onPressed: () {
                 //Route route = MaterialPageRoute(builder: (bc) => VentasPendientes());
                               //Navigator.of(context).push(route);
                               deleteData(doc);
                                  
            },
),
              ),
              
            ],
            
          ),
        ],
        ),
    )
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
          
          
          SizedBox(height: 20.0,),
          
          StreamBuilder<QuerySnapshot>(
            
            stream: db.collection('Inventario').where("Nombre", isEqualTo: selectedCurrency).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => crearCarta(doc)).toList());
                
              } else {
                return SizedBox();
              }
            },
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
        Text('Editar Inventario', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.edit), onPressed: (){}),
      ],),
    ),
  );
}

void updateCantidad(DocumentSnapshot doc) async {
    
    dynamic cantidad;
    String codigo;
    cantidad = double.parse(_textCosto.text);
    codigo = _textCodigo.text.toString();


    await db.collection('Inventario').document(doc.documentID).updateData({ 'Cantidad':cantidad, 'Codigo': '$codigo'});
  
    
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('Inventario').document(doc.documentID).delete();
    setState(() => id = null);
  }

  void mostrarData(DocumentSnapshot doc) async{
    StreamBuilder<QuerySnapshot>(
            
            stream: db.collection('Inventario').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => crearCarta(doc)).toList());
                
              } else {
                return SizedBox();
              }
            },
          );
  }

}