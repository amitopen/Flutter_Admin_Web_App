

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderList extends StatefulWidget{
   var size;
  OrderList({Key key,this.size}): super (key:key) ;

  _OrderListState createState() => _OrderListState();
}
class _OrderListState extends State<OrderList>{
  @override
  void initState() {
    // TODO: implement initState
    countDocuments();
    super.initState();
  }
  void countDocuments() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('product')
        .getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    setState(() {
      widget.size="34";
    });
    print(_myDocCount.length); // Count of Documents in Collection
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('Product')
           // .where('uid', isEqualTo: userId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Text('Loading...');
            default:
              return new Wrap(

                direction: Axis.vertical,
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  return Card(
                    
                    color: Colors.white70,
                    elevation: 5,
                    child: Container(
                      width: 700.0,
                      padding: EdgeInsets.only(top: 5.0,left: 5.0,right: 10.0,bottom: 5.0),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: <Widget>[
                          Wrap(
                            direction: Axis.horizontal,
                            children: <Widget>[

                              new Text('Order Name:',style: TextStyle(fontSize: 20.0,
                                  color: Colors.deepPurple,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 15.0,),
                              Text(document['Product name'],style: TextStyle(
                                  fontSize: 20.0,color: Colors.lightBlue,fontStyle: FontStyle.italic
                              ),),
                              SizedBox(width: 15.0,),

                            ],
                          ),
                          SizedBox(height: 10.0,),

                          Wrap(
                            spacing: 3.0,
                            direction: Axis.horizontal,
                            children: <Widget>[

                              new Text('Price:',style: TextStyle(fontSize: 20.0,
                                  color: Colors.blueAccent,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 15.0,),
                              Text(document['Product Price']+" usd",style: TextStyle(
                                  fontSize: 20.0,color: Colors.lightBlue,fontStyle: FontStyle.italic
                              ),),
                              SizedBox(width: 55.0,),
                              new Text('Delivery Date:',style: TextStyle(fontSize: 20.0,
                                  color: Colors.blueAccent,fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 15.0,),
                              Text(document['Delivry Date'],style: TextStyle(
                                  fontSize: 20.0,color: Colors.lightBlue,fontStyle: FontStyle.italic
                              ),)
                            ],
                          )


                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }


}


