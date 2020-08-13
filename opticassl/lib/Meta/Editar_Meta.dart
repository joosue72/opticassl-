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
   String dropdownValue = '1';
  TextEditingController meta = new TextEditingController();
   TextEditingController meta2 = new TextEditingController();
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
                          dropdownValue = newValue;
                      
                          
                           db
                            .collection("Meta")
                            .where("S",isEqualTo: dropdownValue)
                            .snapshots()
                            .listen((result) {
                          result.documents.forEach((result) {
                            t = result.data['Valor'].toString();
                              total = double.parse(t);
                            print(total);
                            meta.text= "\$"+ total.toString();
                            
                           
                        
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
            
          SizedBox(height: 20),
          Text(name),
  
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


          
          Container(
            
          
            
            child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: meta2,
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
            padding: EdgeInsets.all(82),
            ),
            

          Container(

            width: double.infinity,
            child: FlatButton(
              
              child: Text("Editar"),
              color: Color(0xFFFFC107),
              
              onPressed: (){
                Firestore.instance.collection("Meta").document(dropdownValue).updateData({'Valor': int.parse(meta.text)});
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


           
}