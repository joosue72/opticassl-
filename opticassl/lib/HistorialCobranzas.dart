import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:opticassl/Cobranza.dart';
import 'package:opticassl/Menu.dart';
import 'package:intl/intl.dart';

String id;
  final db = Firestore.instance;
  String nombre, nombre1, apellido1, nombrecompleto;
  DateTime now = DateTime.now();
  String fecha = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
  String tcosto;
  dynamic obtcosto;
  dynamic total;
  dynamic total2;
  dynamic pagoactual;
      String mes = DateFormat('MMM').format(now);
      String dia = DateFormat('d').format(now);

 class HistorialCobranzas extends StatefulWidget {
  HistorialCobranzas({Key key}) : super(key: key);

  @override
  _HistorialCobranzasState createState() => _HistorialCobranzasState();
}

class _HistorialCobranzasState extends State<HistorialCobranzas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getCustomAppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
           StreamBuilder<QuerySnapshot>(
            stream: db.collection('Cobranza').where("Dia", isEqualTo: int.parse(dia)).where("Mes", isEqualTo: mes).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
     
     floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
     onPressed: (){
       Route route = MaterialPageRoute(builder: (bc) => Cobranza());
                               Navigator.of(context).push(route);
     },
     ),
    );
  }

   _displayDialog(BuildContext context, DocumentSnapshot doc) async {

    
    TextEditingController _textFieldController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Editar Total'),
            content: TextField(
              keyboardType: TextInputType.number,
              controller: _textFieldController,
              decoration: InputDecoration(suffixText:'${doc.data['TotalCobranza']}'), 
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('Guardar'),
                onPressed: () {
                  obtcosto = double.parse(_textFieldController.text);
                  print(obtcosto);
                  Navigator.of(context).pop();
                  
                  updateCantidad(doc);


                },
              
              )
            ],
          );
        });
  }

 

   Card buildItem(DocumentSnapshot doc) {
    
    nombre = doc.data['Nombre'];
    
    return Card(
      elevation: 5,
      margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 16.0),
      shape: RoundedRectangleBorder(
        
      borderRadius: BorderRadius.circular(15.0),
    ),
    
    color: Colors.black,
      child: Padding(
        
        
        padding: const EdgeInsets.all(8.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          
          children: <Widget>[
            
           const ListTile(
            title: Text('           Nota', style: TextStyle(color: Color(0xFF009688),)),
            leading: Icon(Icons.note, size: 30, color: Color(0xFF009688),),
          ),
            Text(
              
              'Numero De Notas:          ${doc.data['CantidadNotas']} ',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            
            Text(
              'Total: ${doc.data['TotalCobranza'].toStringAsFixed(2)} \$',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10.0),
            new Container(
  margin: const EdgeInsets.all(10.0),
  padding: const EdgeInsets.all(3.0),
  decoration: BoxDecoration(
    
    border: Border.all(color: Color(0xFF011579B))
  ),
  child: Text('          $fecha', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
),
            
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SizedBox.fromSize(
  size: Size(100, 40), // button width and height
  child: ClipRRect(
    child: Material(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
      color: Color(0xFF64DD17), // button color
      child: InkWell(
        splashColor: Colors.blue, // splash color
        onTap:  () => updateData(doc), // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.payment), // icon
            Text("Pagar", style: TextStyle(color: Colors.black)), // text
          ],
        ),
      ),
    ),
  ),
),
SizedBox(width: 8),
               SizedBox.fromSize(
  size: Size(100, 40), // button width and height
  child: ClipRRect(
    child: Material(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5.0),
    ),
      color: Color(0xFF011579B), // button color
      child: InkWell(
        splashColor: Colors.green, // splash color
        onTap:  () {
          _displayDialog(context, doc);
        }, // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.edit), // icon
            Text("Editar", style: TextStyle(color: Colors.black)), // text
          ],
        ),
      ),
    ),
  ),
),

              ],
            )
          ],
        ),
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
        Text('Cobranzas Del Dia', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.access_time), onPressed: (){}),
      ],),
    ),
  );
}
 void updateData(DocumentSnapshot doc) async {
    await db.collection('Cobranza').document(doc.documentID).updateData({'TotalCobranza': 0});
  }
   void updateCantidad(DocumentSnapshot doc) async {
    total = doc.data['TotalCobranza'];

    
    total -= obtcosto;

    await db.collection('Cobranza').document(doc.documentID).updateData({'TotalCobranza': total});
  
    
  }
}