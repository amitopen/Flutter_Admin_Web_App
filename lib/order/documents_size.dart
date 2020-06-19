


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

 class DocumentsSize extends StatefulWidget{
   String size="";
  DocumentsSize({this.size});
  _DocumentsSizeState createState() => _DocumentsSizeState();
}
class _DocumentsSizeState extends State<DocumentsSize> {

  @override
  Widget build(BuildContext context) {
    return Text("");
  }
   void countDocuments() async {
    QuerySnapshot _myDoc = await Firestore.instance.collection('product')
        .getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    setState(() {
      widget.size=_myDocCount.length.toString();
    });
    print(_myDocCount.length); // Count of Documents in Collection
  }
}
