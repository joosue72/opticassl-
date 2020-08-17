import 'dart:async';

import 'package:OpticaSl/MenuGrafica.dart';
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
   String dropdownValue = '1';
  TextEditingController meta = new TextEditingController();

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
                            .collection("Meta")
                            .where("S",isEqualTo: dropdownValue)
                            .snapshots()
                            .listen((result) {
                          result.documents.forEach((result) {
                            t = result.data['Valor'].toString();
                              total = double.parse(t);
                         
                            meta.text=  total.toString();
                            print(total);
                        
                          });
                                
                          });
        

              db
                .collection('VentasSucursal1')
                .where("Mes", isEqualTo: currentPage + 1) 
                .where("Sucursal",isEqualTo:dropdownValue)
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
       
         
       
  
         });
        }, 
        
        child:ListView(
          
          children: <Widget>[

             SizedBox(height: 20),
             Form(
          
            
                      child: new Container(
              child: new Row(

                children: <Widget>[

                   Text('   Sucursal: ' ,textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),

               Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),

                  // dropdown below..
                  child: DropdownButton<String>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      underline: SizedBox(),
                      onChanged: (String newValue) {
                      
                       
                        setState(()  {

                           resultado = 0;

                           

                          
                          dropdownValue = newValue;
                      
                           db
                            .collection("Meta")
                            .where("S",isEqualTo: dropdownValue)
                            .snapshots()
                            .listen((result) {
                          result.documents.forEach((result) {
                            t = result.data['Valor'].toString();
                              total = double.parse(t);
                         
                            meta.text=  total.toString();

                        
                          });
                                
                          });


                          db
                              .collection('VentasSucursal1')
                              .where("Mes", isEqualTo: currentPage + 1) 
                              .where("Sucursal",isEqualTo:dropdownValue)
                              .snapshots()
                              .listen((result) {
                              result.documents.forEach((result) { 
                                t = result.data['Costo'].toString();

                                total1 = double.parse(t);
                                
                                  
                                
                                  resultado = resultado + double.parse(t);
                                  
                              
                                    
                              });
                        
                                print(resultado); 
                              
                                  
                              });

                            
                            

                               Future.delayed(const Duration(milliseconds: 200), () {

                                  

                                    setState(() {

                                                print(meta.text);

                                        
                                            porcentaje = (resultado * 100 /double.parse(meta.text))/100;
                                            print(porcentaje);
                                      
                                        
                                          

                                        if(total < resultado){
                    
                                            
                                              porcentaje = .01000 * 100;
                                            
                                            }
                                      
                                    });

                                  });



                           
                               
                           
                          

                        });
                      },
                      items: <String>[
                        '1',
                        '2',
                        '3',
                        '4',
                        '5',
                        '6',
                        '7',
                        '8',
                        '9',
                        '10',
                        
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()),
                ),



                ],
              ),

              
            ),
                   
          ),
            
            SizedBox(height: 10),

                Container(
            
          
            
            child: TextField(
                enableInteractiveSelection: false,
                enabled: false, 
                keyboardType: null,
                 textAlign: TextAlign.center,
                
                controller: meta,
                style: TextStyle(

                    
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0
                  ),
            decoration: InputDecoration(
             
           
              
                 filled: false,
              
            ),
             
            ),
            

            padding: EdgeInsets.all(12),
            ),

              Container(

                      child: Text("Meta",
                       textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.blueGrey,
                  ),
                ),

            
            ),

            
           
            
            CircularPercentIndicator(
              progressColor: Colors.blueGrey,
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
              progressColor: Colors.blueGrey,
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
      child: Icon( Icons.add , color: Colors.white),
      backgroundColor: Color(0xFF011579B),
            
      onPressed: (){
                               
         Route route = MaterialPageRoute(builder: (bc) => editar_meta());
         Navigator.of(context).push(route);
         },
    );
  }


  

 
}