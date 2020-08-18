import 'package:OpticaSl/Agendas.dart';
import 'package:OpticaSl/Menu.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

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
  int numerofecha;
  int _currentValue = 1;

  




 class AgendasActuales extends StatefulWidget {
  AgendasActuales({Key key}) : super(key: key);

  @override
  _AgendasActualesState createState() => _AgendasActualesState();
}

class _AgendasActualesState extends State<AgendasActuales> {


  


  @override
  Widget build(BuildContext context) {

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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _getCustomAppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
          padding: const EdgeInsets.only(left: 130.0),
          child: Container(child: Text("Sucursal",
            style: TextStyle(color: Colors.blue, fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
          new NumberPicker.integer(
                
                initialValue: _currentValue,
                minValue: 1,
                maxValue: 10,
                onChanged: (newValue) =>
                    setState(() => _currentValue = newValue)),
          SizedBox(height: 30.0,),
           StreamBuilder<QuerySnapshot>(
            stream: db.collection('Agendas').where("Sucursal", isEqualTo: _currentValue).where("Dia", isEqualTo: int.parse(dia)).where("Mes", isEqualTo: numerofecha).snapshots(),
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
       Route route = MaterialPageRoute(builder: (bc) => Agendas());
                               Navigator.of(context).push(route);
     },
     ),
    );
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
            title: Text('                     Cita', style: TextStyle(color: Color(0xFF009688),)),
            leading: Icon(Icons.calendar_today, size: 20, color: Color(0xFF009688),),
          ),
            Text(
              
              'Nombre:          ${doc.data['Nombre']} ',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            
            Text(
              'Hora: ${doc.data['Hora']}  ',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 10.0),
            new Container(
  margin: const EdgeInsets.all(10.0),
  padding: const EdgeInsets.all(3.0),
  decoration: BoxDecoration(
    
    border: Border.all(color: Color(0xFF011579B))
  ),
  child: Text('Sucursal:        ${doc.data['Sucursal']}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
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
      color: Color(0xFFFF1744), // button color
      child: InkWell(
        splashColor: Colors.blue, // splash color
        onTap:  () => showAlertDialog(context, doc), // button pressed
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.delete_forever), // icon
            Text("Borrar", style: TextStyle(color: Colors.black)), // text
          ],
        ),
      ),
    ),
  ),
),
SizedBox(width: 8),
              

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
        Text('Citas Del Dia', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.access_time), onPressed: (){}),
      ],),
    ),
  );
}
 
 void deleteData(DocumentSnapshot doc) async {
    await db.collection('Agendas').document(doc.documentID).delete();
    setState(() => id = null);
  }
showAlertDialog(BuildContext context, DocumentSnapshot doc) {

  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Borrar"),
    onPressed:  () {
      deleteData(doc);
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alerta!"),
    content: Text("¿Estás seguro de que quieres eliminar esta Cita?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

}