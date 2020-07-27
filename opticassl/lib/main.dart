import 'package:flutter/material.dart';
import 'dart:async';
import 'Login.dart';
import 'Grafica_Ventas/details_page.dart';





void main() {
  runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyApp(),
  onGenerateRoute: (settings) {
         if(settings.name == '/details'){
           DetailsPage params = settings.arguments;
           return MaterialPageRoute(builder: (BuildContext context){
             return DetailsParams(params: params,);});
         }

        }
));
}

int n1;

class MyApp  extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    super.initState();
    Future.delayed(
      
    Duration(seconds: 4),
    (){
      Navigator.push(
        context,
       
        MaterialPageRoute(
          
        builder: (context) => Login(),
        ),
      );
    },
  );
}

 


@override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Container(
       decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/12.gif"),
            fit: BoxFit.cover,
          ),
        ),  
      
      ),
        
    );
  }
}