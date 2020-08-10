import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:OpticaSl/Meta/Grafica_Meta.dart';


class editar_meta extends StatefulWidget {
  @override
  _editar_metaState createState() => _editar_metaState();
}

 String t ; double total;

class _editar_metaState extends State<editar_meta> {
GlobalKey<RefreshIndicatorState> refreshKey;
   final db = Firestore.instance;
 
  final _controller = TextEditingController();
  String name = "";
  TextEditingController meta = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    traermeta();
    return Scaffold(
      appBar: _getCustomAppBar(),
        
      
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async{
         setState(() { traermeta(); });
        }, 
        child:ListView(
          
       // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30),
          Text(name),
          _expenses2(),
          Container(
            
            child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: meta,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xFFFFC107)),
                 borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
                 ),
                 prefixIcon: Icon(Icons.edit),
                 hintText: "Editar Meta",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            ),
            padding: EdgeInsets.all(32),
            ),
            

          Container(

            width: double.infinity,
            child: FlatButton(
              
              child: Text("Editar"),
              color: Color(0xFFFFC107),
              
              onPressed: (){
                Firestore.instance.collection("Meta").document('J8LlpZ35rNvcL8EaSdrd').updateData({'Valor': meta.text});
              },
            ),
            padding: EdgeInsets.all(32),
            alignment: Alignment.bottomRight,

            
          )
          

        ],)
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
            Color(0xFFFFC107),
            Color(0xFFFFFFFF),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
        IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: (){
          Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Meta()),
    
  );

        }),
        Text('Establecer Meta', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.inbox), onPressed: (){}),
      ],),
    ),
  );
}

  void traermeta(){

        
          db
          .collection("Meta")
          .snapshots()
          .listen((result) {
        result.documents.forEach((result) {
          t = result.data['Valor'].toString();
            total = double.parse(t);

      
        });
              
        });

        

     }


    Widget _expenses2() {
   
    return Column(
      children: <Widget>[
        
        Text("\$${total}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0
          ),
        ),
        Text("Meta",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }
}