
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Employee extends StatefulWidget {

  _EmployeeState createState() => _EmployeeState();
}

class  _EmployeeState extends State<Employee>{

  String userId;

  Future<void> getUserDoc() async {
    FirebaseUser userData = await FirebaseAuth.instance.currentUser();

    setState(() {
      userId = userData.uid;



    });

  }
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getUserDoc();
  }
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('Product')
              //.where('uid', isEqualTo: userId)
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
                    return Wrap(
                      direction: Axis.vertical,
                      children: <Widget>[
                        Wrap(
                          direction: Axis.horizontal,
                          children: <Widget>[

                            new Text('Order Name:',style: TextStyle(fontSize: 28.0,
                                color: Colors.blueAccent,fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 15.0,),
                            Text(document['Product name'],style: TextStyle(
                                fontSize: 28.0,color: Colors.lightBlue,fontStyle: FontStyle.italic
                            ),),
                            SizedBox(width: 15.0,),

                          ],
                        ),

                        Wrap(
                          direction: Axis.horizontal,
                          children: <Widget>[

                            new Text('Price:',style: TextStyle(fontSize: 28.0,
                                color: Colors.blueAccent,fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 15.0,),
                            Text(document['Product Price'],style: TextStyle(
                                fontSize: 28.0,color: Colors.lightBlue,fontStyle: FontStyle.italic
                            ),),
                          ],
                        ),

                      RaisedButton(
                        color: Colors.blue,
                        onPressed: countDocuments,
                      )
                      ],
                    );
                  }).toList(),
                );
            }
          },
        ),

      ),

    );
  }
  void countDocuments() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('Product').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    print(_myDocCount.length);  // Count of Documents in Collection
  }

}