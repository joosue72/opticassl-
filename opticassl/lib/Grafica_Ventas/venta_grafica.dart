import 'package:OpticaSl/MenuGrafica.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:OpticaSl/Menu.dart';
import 'package:OpticaSl/Ventas.dart';
import 'venta_widget.dart';

class venta_grafica extends StatefulWidget {
 
  

  @override
  _venta_graficaState createState() => _venta_graficaState();
}

class _venta_graficaState extends State<venta_grafica> {

   PageController _controller;
  int currentPage = DateTime.now().month - 1;
  int currentPage2 = DateTime.now().day;
  Stream<QuerySnapshot> _query;
  GraphType currentType = GraphType.LINES;
  int dropdownValue = 1;

  @override
  void initState() {
    super.initState();

    _query = Firestore.instance

        .collection('VentasSucursal1')
        .where('Sucursal', isEqualTo: dropdownValue)
        .where("Mes", isEqualTo: currentPage + 1)
        .snapshots();

    _controller = PageController(
      initialPage: currentPage,
      viewportFraction: 0.4,
    );
  }

  Widget _bottomAction(IconData icon, Function callback) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon),
      ),
      onTap: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(currentPage2);
    return Scaffold(
     appBar: _getCustomAppBar(),




     
      bottomNavigationBar: BottomAppBar(
          notchMargin: 8.0,
          shape: CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _bottomAction(FontAwesomeIcons.chartLine, () {
                setState(() {
                  
                  currentType = GraphType.LINES;
                });
              }),
              SizedBox(width: 48.0),
             _bottomAction(FontAwesomeIcons.chartPie, () {
                setState(() {
                  currentType = GraphType.PIE;
                });
              }),
            ],
          ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        
        child: Icon(Icons.add),
        backgroundColor: Colors.blueAccent,
        onPressed: () {
            Navigator.push(context,  MaterialPageRoute(builder: (context) => Ventas()),);

          
        },
      ),
      body: _body(),

      
    );
  }

  Widget _body() {
    return SafeArea(
      child: Column(
     
        children: <Widget>[
       
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
                  child: DropdownButton<int>(
                      value: dropdownValue,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 42,
                      underline: SizedBox(),
                      onChanged: (int newValue) {
                       
                        setState(()  {
                          dropdownValue = newValue;
                      
                          
                        _query = Firestore.instance
                        .collection('VentasSucursal1')
                        .where('Sucursal', isEqualTo: dropdownValue)
                        .where("Mes", isEqualTo: currentPage + 1)
                        .snapshots();

                        });
                      },
                      items: <int>[
                        1,
                        2,
                        3,
                        4,
                        5,
                        6,
                        7,
                        8,
                        9,
                        10,
                        
                      ].map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList()),
                ),



                ],
              ),

              
            ),
                   
          ),
          _selector(),
          StreamBuilder<QuerySnapshot>(
            stream: _query,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data) {
              if (data.hasData) {

                

                // ignore: dead_code
                return VentaWidget(

                  
                  
                  documents: data.data.documents,
                  graphType: currentType,
                  month: currentPage,
                );

              }

              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _pageItem(String name, int position) {
    var _alignment;
    final selected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      color: Colors.blueGrey,
    );
    final unselected = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.normal,
      color: Colors.blueGrey.withOpacity(0.4),
    );

    if (position == currentPage) {
      _alignment = Alignment.center;
    } else if (position > currentPage) {
      _alignment = Alignment.centerRight;
    } else {
      _alignment = Alignment.centerLeft;
    }

    return Align(
      alignment: _alignment,
      child: Text(name,
        style: position == currentPage ? selected : unselected,
      ),
    );
  }

  Widget _selector() {
    return SizedBox.fromSize(
      size: Size.fromHeight(70.0),
      child: PageView(
        onPageChanged: (newPage) {
          setState(() {
            currentPage = newPage;
            _query = Firestore.instance
                .collection('VentasSucursal1')
                .where("Mes", isEqualTo: currentPage + 1)
                .snapshots();
          });
        },
        controller: _controller,
        children: <Widget>[
          _pageItem("Enero", 0),
          _pageItem("Febrero", 1),
          _pageItem("Marzo", 2),
          _pageItem("Abril", 3),
          _pageItem("Mayo", 4),
          _pageItem("Junio", 5),
          _pageItem("Julio", 6),
          _pageItem("Agosto", 7),
          _pageItem("Septiembre", 8),
          _pageItem("Octubre", 9),
          _pageItem("Noviembre", 10),
          _pageItem("Diciembre", 11),
        ],
      ),
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
  MaterialPageRoute(builder: (context) => MenuGraficas()),
 );

        }),
        Text('Lista Ventas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.trending_up), onPressed: (){}),
      ],),
    ),
  );
}
}