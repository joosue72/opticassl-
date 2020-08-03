import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opticassl/Menu.dart';





 class HistorialClientes extends StatefulWidget {
  HistorialClientes({Key key}) : super(key: key);

  @override
  _HistorialClientesState createState() => _HistorialClientesState();
}

TextEditingController _textCosto = TextEditingController();
TextEditingController _textBuscador = TextEditingController();
final myController = TextEditingController();
String id;
final db = Firestore.instance;
var selectedCurrency, selectedType;
String buscar;
class _HistorialClientesState extends State<HistorialClientes> {

  

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
                 hintText: "${doc.data['Pago']}",
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
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("${doc.data['Fecha']}",
            style: TextStyle(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.bold),)),
        ),
           SizedBox(height: 10.0,),
           Form(child: buildTextFormFieldCosto(doc)),
           
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
                 
                               updateCantidad(doc);
                               _textCosto.text="";
                                          
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
      backgroundColor: Colors.white,
      appBar: _getCustomAppBar(),
       body: ListView(
        padding: EdgeInsets.all(8),
        children: <Widget>[
          
            SizedBox(height: 15.0,),
             StreamBuilder<QuerySnapshot>(
             stream: db.collection('HistorialClientes').orderBy('Nombre').limit(50).snapshots(),
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
    MaterialPageRoute(builder: (context) => HomeScreen()),
  );

        }),
        Text('Historial Clientes', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.history), onPressed: (){}),
      ],),
    ),
  );
}

void updateCantidad(DocumentSnapshot doc) async {
    
    dynamic cantidad;
    
    cantidad = double.parse(_textCosto.text);
    


    await db.collection('HistorialClientes').document(doc.documentID).updateData({ 'Pago':cantidad});
  
    
  }

  void filtrarDatos()
  {
    StreamBuilder<QuerySnapshot>(
            stream: db.collection('HistorialClientes').where("Filtrar", isEqualTo: _textBuscador ).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => crearCarta(doc)).toList());
              } else {
                return SizedBox();
              }
            },
          );
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('HistorialClientes').document(doc.documentID).delete();
    setState(() => id = null);
  }

  

}