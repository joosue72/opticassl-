import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:opticassl/Menu.dart';


class Inventario extends StatefulWidget {
  Inventario({Key key}) : super(key: key);

  @override
  _Inventario createState() => _Inventario();
}

final db = Firestore.instance;

class _Inventario extends State<Inventario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _getCustomAppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
           StreamBuilder<QuerySnapshot>(
            stream: db.collection('Inventario').where("Cantidad", isGreaterThan: -1).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(children: snapshot.data.documents.map((doc) => cardbuild(doc)).toList());
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
     
     floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
     onPressed: (){},
     ),
    );
  }
   Widget cardbuild(DocumentSnapshot doc)
  {
    return Column(children: <Widget>[
       Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(16.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        myDetailsContainer1(doc),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                           
                          ),
                        ),

                        
                      ],)
                ),
              ),
            ),
          ),
    ],);
   
  }
   Widget myDetailsContainer1(DocumentSnapshot doc) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("${doc.data['Nombre']}",
            style: TextStyle(color: Color(0xFF011579B), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(child: Text("Cantidad ",
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
                  Container(child: Icon(
                    FontAwesomeIcons.server, color: Colors.amber,
                    size: 15.0,),),
                  
                  Container(child: Text(" (${doc.data['Cantidad']}) \u00B7 Pz",
                    style: TextStyle(color: Colors.black54, fontSize: 18.0,),)),
                ],)),     
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(child: Text("${doc.data['Codigo']}",
            style: TextStyle(color: Color(0xFF011579B), fontSize: 24.0,fontWeight: FontWeight.bold),)),
        ),
        SizedBox(height: 10,),
        Container(child: Text("   Optica SL \u00B7 Sucursal 1   ",
          style: TextStyle(color: Colors.black54, fontSize: 18.0,fontWeight: FontWeight.bold),)),
      ],
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
        Text('Inventario', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.storage), onPressed: (){}),
      ],),
    ),
  );
}
}