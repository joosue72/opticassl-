import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:OpticaSl/Menu.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

import 'Editar_Meta.dart';

const List<Key> keys = [
    Key('Network'),
    Key('Network Dialog'),
    Key('Flare'),
    Key('Flare Dialog'),
    Key('Asset'),
    Key('Asset dialog'),


  ];

class Meta extends StatefulWidget {

  


 

   
    


  @override
  _MetaState createState() => _MetaState();
}
String t ; double total;
Timer _timer;
 double total1;

 double resultado;
 double porcentaje = 0;
class _MetaState extends State<Meta> {
 int currentPage = DateTime.now().month - 1;
   Stream<QuerySnapshot> _query;
 
  final db = Firestore.instance;
  GlobalKey<RefreshIndicatorState> refreshKey;

   @override
  void initState() {
    super.initState();

    refreshKey = GlobalKey<RefreshIndicatorState>();
     traermeta();
    
          
    
      int currentPage = DateTime.now().month - 1;
      resultado = 0;
        

              db
                .collection('VentasSucursal1')
                .where("Mes", isEqualTo: currentPage + 1) 
                .snapshots()
                .listen((result) {
                result.documents.forEach((result) { 
                  t = result.data['Costo'].toString();

                  total1 = double.parse(t);
                  
                
                  
                    resultado = resultado + double.parse(t);
                     
                
                      
                });
          
                  print(resultado); 
                 
                    
                });
            

    
      
  }

   Widget _expenses()  {

    return Column(
      children: <Widget>[

        
        Text("\$${total}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0
          ),
        ),
        Text("Meta de Ventas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

 

    
 Future<Null> refreshList() async {
   await Future.delayed(Duration(seconds: 2));
 }
 
   @override
   
   Widget build(BuildContext context) {


   
      



 

     
    
    return Scaffold(
      
      appBar: _getCustomAppBar(),
      body: RefreshIndicator(
        //padding:EdgeInsets.all(25.0),
        key: refreshKey,
        onRefresh: () async{
         setState(() {
       
         
         if(total > resultado){
        
        porcentaje = (resultado * 100 /total)/100;
         _expenses();
         _expenses();
       
        }

        else{
          porcentaje = .01000 * 100;
          
        }
  
         });
        }, 
        
        child:ListView(
          
          children: <Widget>[
            
            SizedBox(height: 30),
            
            _expenses(),
            
            CircularPercentIndicator(
              progressColor: Colors.redAccent,
              percent: porcentaje,
              animation:true,
              radius:250.0,
              lineWidth:20.0,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text((porcentaje * 100).toStringAsFixed(2)+ "%"),
            ),
          _expenses2(),

            LinearPercentIndicator(
              alignment: MainAxisAlignment.center,
              width: 250.0,
              lineHeight: 15.0,
              progressColor: Colors.orangeAccent,
              percent: porcentaje,
              center: Text((porcentaje * 100).toStringAsFixed(2)+ "%"),
              animation: true,
            ),
            
            

          ],
        )
      ), floatingActionButton: _crearBoton( context ),
      
    );
   }
  
  _getCustomAppBar(){
  return PreferredSize(
    preferredSize: Size.fromHeight(50),
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
    MaterialPageRoute(builder: (context) => HomeScreen()),
    
  );

        }),
        Text('Meta', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.inbox), onPressed: (){}),
      ],),
    ),
  );
}

  
    traermeta() async{
       db
          .collection("Meta")
          .snapshots()
          .listen((result) {
        result.documents.forEach((result) {
          t = result.data['Valor'].toString();
            total = double.parse(t);
            print(total);
        });
              
        });

       

    
       

     }
   
 

  Widget _expenses2() {
    
   
   
    return Column(
      children: <Widget>[
        
        Text("\$${resultado}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0
          ),
        ),
        Text("Total de Ventas",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
      
    );
    
  }
 
   _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon( Icons.add , color: Colors.black),
      backgroundColor: Color(0xFFFFC107),
            
      onPressed: (){
                               
         Route route = MaterialPageRoute(builder: (bc) => editar_meta());
         Navigator.of(context).push(route);
         },
    );
  }


  

 
}