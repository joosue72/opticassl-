import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../MenuGrafica.dart';

void main() => runApp(Ganancias());

class Ganancias extends StatefulWidget {
  Ganancias({Key key}) : super(key: key);

  @override
  _GananciasState createState() => _GananciasState();
}

int currentPage = DateTime.now().month - 1;
     final db = Firestore.instance;
     String t ;
      String t2 ;
      double t3;
     double resultado = 0;
     double resultado2 = 0;
      String dropdownValue = '1';
        TextEditingController meta = new TextEditingController();
   TextEditingController meta2 = new TextEditingController();
   TextEditingController meta3 = new TextEditingController();
double total1;
class _GananciasState extends State<Ganancias> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar Graph Demo',
      debugShowCheckedModeBanner: false,
      home: BarGraphDemo(),
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}

class BarGraphDemo extends StatefulWidget {
  BarGraphDemo({Key key}) : super(key: key);

  @override
  _BarGraphDemoState createState() => _BarGraphDemoState();
}

class _BarGraphDemoState extends State<BarGraphDemo> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List<AppDownloads> data;
  @override
  void initState() {
    super.initState();

     resultado = 0;
     resultado2 = 0;

     db
                .collection('VentasSucursal1')
                .where("Mes", isEqualTo: currentPage + 1) 
                .where("Sucursal", isEqualTo: dropdownValue)
                .snapshots()
                .listen((result) {
                result.documents.forEach((result) { 
                  t = result.data['Costo'].toString();

               
                  
                
                  
                    resultado = resultado + double.parse(t);
                  
              
                                      
                
                      
                });
          
                  
                  
                  print(resultado); 
                    
                });


                 db
                .collection('Gastos')
                .where("Mes", isEqualTo: currentPage + 1) 
                .where("Sucursal", isEqualTo: dropdownValue)
                .snapshots()
                .listen((result) {
                result.documents.forEach((result) { 
                  t2 = result.data['Cantidad'].toString();

               
                  
                
                  
                    resultado2 = resultado2 + double.parse(t2);
                  
              
                                      
                
                      
                });
          
                  
                  
                  print(resultado2); 
                    
                });
            
            
            
          
          data = [

                        AppDownloads(
                          year: 'Gastos',
                          count: resultado2,
                          barColor: charts.ColorUtil.fromDartColor(Colors.blue),
                        ),
                        AppDownloads(
                          year: 'Ventas',
                          count: resultado,
                          barColor: charts.ColorUtil.fromDartColor(Colors.green), 
                        ),
                      ]; 


       
  }

  @override
  Widget build(BuildContext context) {

   
    return Scaffold(
      appBar: _getCustomAppBar(),
      body: RefreshIndicator(

         key: refreshKey,
        onRefresh: () async{
         setState(() { 
            data = [

                        AppDownloads(
                          year: 'Gastos',
                          count: resultado2,
                          barColor: charts.ColorUtil.fromDartColor(Colors.blue),
                        ),
                        AppDownloads(
                          year: 'Ventas',
                          count: resultado,
                          barColor: charts.ColorUtil.fromDartColor(Colors.green), 
                        ),
                      ];  });
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
                          resultado2 = 0;
                          dropdownValue = newValue;

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
                                  meta2.text =  "\$" +resultado.toString();
                              
                                    
                              });
                        
                                
                              
                                  
                              });

                              


                               db
                                    .collection('Gastos')
                                    .where("Mes", isEqualTo: currentPage + 1) 
                                    .where("Sucursal", isEqualTo: dropdownValue)
                                    .snapshots()
                                    .listen((result) {
                                    result.documents.forEach((result) { 
                                      t2 = result.data['Cantidad'].toString();

                                  
                                      
                                    
                                      
                                        resultado2 = resultado2 + double.parse(t2);
                                      
                                  
                                                          
                                      meta3.text =  "\$"+resultado2.toString();
                                          
                                    });
                              
                                      
                                      
                                      print(resultado2); 
                                        
                                    });


                                     Future.delayed(const Duration(milliseconds: 200), () {

                                  

                                    setState(() {

                                        t3 = resultado - resultado2;

                                         meta.text= "\$"+t3.toString();

                                          data = [

                                          AppDownloads(
                                            year: 'Gastos',
                                            count: resultado2,
                                            barColor: charts.ColorUtil.fromDartColor(Colors.blue),
                                          ),
                                          AppDownloads(
                                            year: 'Ventas',
                                            count: resultado,
                                            barColor: charts.ColorUtil.fromDartColor(Colors.green), 
                                          ),
                                        ];
                                      
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

            
            

            padding: EdgeInsets.all(2),
            ),

            
            Container(

                      child: Text("Ganancias",
                       textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.blueGrey,
                  ),
                ),

            
            ),









          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Card(
              child: MyBarChart(data),
            ),
          ),

          

           SizedBox(height: 10),

                Container(
            
          
            
            child: TextField(
                enableInteractiveSelection: false,
                enabled: false, 
                keyboardType: null,
                 textAlign: TextAlign.center,
                
                controller: meta2,
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

                      child: Text("Ventas",
                       textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.blueGrey,
                  ),
                ),

            
            ),




            Container(
            
          
            
            child: TextField(
                enableInteractiveSelection: false,
                enabled: false, 
                keyboardType: null,
                 textAlign: TextAlign.center,
                
                controller: meta3,
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

                      child: Text("Gastos",
                       textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.blueGrey,
                  ),
                ),

            
            ),
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
    MaterialPageRoute(builder: (context) => MenuGraficas()),
    
  );

        }),
        Text('Ganancias', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.inbox), onPressed: (){}),
      ],),
    ),
  );
}
}

class AppDownloads {
  final String year;
  final double count;
  final charts.Color barColor;

  AppDownloads({
    @required this.year,
    @required this.count,
    @required this.barColor,
  });
}

class MyBarChart extends StatelessWidget {
  final List<AppDownloads> data;

  MyBarChart(this.data);

  @override
  Widget build(BuildContext context) {
    List<charts.Series<AppDownloads, String>> series = [
      charts.Series(
          id: 'AppDownloads',
          data: data,
          domainFn: (AppDownloads downloads, _) => downloads.year,
          measureFn: (AppDownloads downloads, _) => downloads.count,
          colorFn: (AppDownloads downloads, _) => downloads.barColor)
    ];

    return charts.BarChart(
      series,
      animate: true,
      barGroupingType: charts.BarGroupingType.groupedStacked,
    );
  }
}