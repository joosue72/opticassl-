import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DetailsPage2{
  final String categoryName;
  final int month;

  DetailsPage2(this.categoryName, this.month);
}

class DetailsParams2 extends StatefulWidget {
  final DetailsPage2 params;

  const DetailsParams2({Key key, this.params}) : super(key: key);
  @override
  _DetailsParams2State createState() => _DetailsParams2State();
}

class _DetailsParams2State extends State<DetailsParams2> {
  @override
  Widget build(BuildContext context) {

     var _query = Firestore.instance
                .collection('Cantidad')
                .where("Mes", isEqualTo: widget.params.month + 1)
                .where("Nombre", isEqualTo: widget.params.categoryName)
                .snapshots();

    return Scaffold(
     appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          centerTitle: true,
           title: Text("Descripción"),
        backgroundColor: Colors.orange[700]
        ),
        
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _query,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> data){
          if(data.hasData)
          {
            return ListView.builder(
              itemBuilder: (BuildContext context,int index){
                var document = data.data.documents[index];

                return Dismissible(
                  key: Key(document.documentID),
                  onDismissed: (direction){
                    Firestore.instance
                      .collection('Cantidad')
                      .document(document.documentID)
                      .delete();

                  },
                    child: ListTile(
                   leading: Stack(
               
                     children: <Widget>[
                       
                       Icon(Icons.calendar_today,size: 40,),
                       Positioned(
                         left: 0,
                         right: 0,
                         bottom: 8,
                         child: Text(document["Dia"].toString(), textAlign: TextAlign.center,), 
                         ),
                   ],),
                   title:Container(
                        decoration: BoxDecoration(
                          color: Colors.blueAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("\ ${document["Nombre"]}",
                                    style: TextStyle(
                                      color:Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.0,
                              ),
                           ),
                       )
        
                     ),
      

                  ),
                );
            },
              itemCount: data.data.documents.length,
            );
          }

          return Center(child: CircularProgressIndicator()
          );
        },

        )
       
    );
  }

  
}


