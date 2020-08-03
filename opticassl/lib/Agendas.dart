import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:opticassl/Menu.dart';
import 'package:numberpicker/numberpicker.dart';





 class Agendas extends StatefulWidget {
  Agendas({Key key}) : super(key: key);

  @override
  _AgendasState createState() => _AgendasState();
}


TextEditingController _textCosto = TextEditingController();
String id;
String _dateTime;
final db = Firestore.instance;
TimeOfDay _time = TimeOfDay.now();
TimeOfDay picked;
int _currentValue = 1;
String hora;
String formattedDate;

class _AgendasState extends State<Agendas> {

  Future<Null> selectTime(BuildContext context) async{
    picked = await showTimePicker(
      context: context, 
      initialTime: _time,
      
      );

      

    setState(() {
      hora =_time.format(context);
      _time = picked;
      print(_time);
    });
  }


TextFormField buildTextFormFieldCosto() {

     return TextFormField(
                keyboardType: TextInputType.text,
                controller: _textCosto,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Color(0xFF009688)),
                 borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              focusedBorder: OutlineInputBorder(
                 borderSide: BorderSide(color: Colors.transparent),
                 borderRadius: BorderRadius.all(Radius.circular(30))
                 ),
                 prefixIcon: Icon(Icons.remove_red_eye),
                 hintText: "Nombre",
                 filled: true,
                 fillColor: Colors.grey[200]
            ),
             
            );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: _getCustomAppBar(), 
      body: ListView(
        padding: EdgeInsets.all(8),
        
        children: <Widget>[
         
          SizedBox(height: 50.0),
          Form(
            child: buildTextFormFieldCosto(),
            
            
          ),

          
         
           SizedBox(height: 20.0),
           
           SizedBox(height: 20.0),
           Form(

                      child: new Container(
              child: new Row(

                children: <Widget>[

                Text(_dateTime == null ? 'No hay fecha seleccionada' : _dateTime.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),


                new IconButton(

                  
                  color: Color(0xFF009688), 
                   icon: Icon(Icons.calendar_today,size: 30, ),
                          onPressed: () {
                               showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2001), lastDate: DateTime(2222)).then((date){
                                   formattedDate = DateFormat('dd-MM-yyyy').format(date);
                      setState(() {
                        print(formattedDate);
                        _dateTime = formattedDate;
                      });
                  });
                              
                          },
                 


                  ),


                ],
              ),

              
            ),
                    
              
           ),
             SizedBox(height: 50.0),
          Form(
          
            
                      child: new Container(
              child: new Row(

                children: <Widget>[

                Text( _time.format(context),textAlign: TextAlign.center,style: TextStyle(fontSize: 25),),


                IconButton(
                   color: Color(0xFF009688), 
              icon: Icon(Icons.alarm,size: 30, ),
              onPressed: (){
                selectTime(context);
              
              }
            ,),


                ],
              ),

              
            ),
                   
          ),
            SizedBox(height: 10.0,),
          Form(
            child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new NumberPicker.integer(
                
                initialValue: _currentValue,
                minValue: 1,
                maxValue: 10,
                onChanged: (newValue) =>
                    setState(() => _currentValue = newValue)),
            new Text("Sucursal: $_currentValue",style: TextStyle(color: Colors.white),),
          ],
        ),
          ),
          SizedBox(height: 70.0),
          ButtonTheme(
                
                minWidth: 250.0,
                height: 50.0,
                child: RaisedButton(
    color: Color(0xFF009688), 
    child: Row( 
    mainAxisAlignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.max, 
    children: <Widget>[
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(
              "Generar Cita",
              style: TextStyle(
                fontSize: 18, 
                color: Colors.white, 
              ),
          ),
        ),
        Icon(
          Icons.send, 
          color: Colors.white,
          size: 20, 
        ),
    ],
    ),
            onPressed: () {
                 createData();
                 _textCosto.text = "";
                 
            },
),
              ),
        ],
      ),
    );
  }

  void createData() async {
  String nombre;
  String fecha;
  nombre =_textCosto.text;
  hora =_time.format(context);
  fecha = formattedDate;
      print(hora);
        DocumentReference ref = await db.collection('Agendas').add({'Fecha': '$fecha','Nombre':'$nombre','Hora':'$hora','Sucursal':'$_currentValue'});
      setState(() => id = ref.documentID);  
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
        Text('Agendas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
        IconButton(icon: Icon(Icons.edit), onPressed: (){}),
      ],),
    ),
  );
}
}