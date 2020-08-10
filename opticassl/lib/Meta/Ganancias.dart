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
     double resultado = 0;
     double resultado2 = 0;

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
           _expenses2(),
          Container(
            height: 200,
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Card(
              child: MyBarChart(data),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(

              child: _expenses3(),
              
             
            ),
          ),

          _expenses4()
        ],
      ),
      ),
    );
  }

   Widget _expenses2() {
   
    return Column(
      children: <Widget>[
        
        Text("\$${resultado - resultado2}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
             color: Colors.greenAccent,
          ),
        ),
        Text("Ganancias",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

   Widget _expenses3() {
   
    return Column(
      children: <Widget>[
        
        Text("\$${resultado }",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
           
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

   Widget _expenses4() {
   
    return Column(
      children: <Widget>[
        
        Text("\$${resultado2}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0
          ),
        ),
        Text("Total de Gastos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.blueGrey,
          ),
        ),
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