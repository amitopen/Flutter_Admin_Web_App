
import 'package:canary_admin/components/CardContentTitle.dart';
import 'package:canary_admin/order/get_order_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //this is an external package for formatting date and time
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

class Customer extends StatefulWidget {
  final String dateSelectecInput;
  Customer({Key key,this.dateSelectecInput}):super(key:key);
  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
  final GlobalKey<FormState> _productInputFormKey = GlobalKey<FormState>();
  TextEditingController projectNameInputController;
  TextEditingController projectPriceInputController;



  final databaseReference = Firestore.instance;

  String formattedDate;

  @override
  void initState() {
    // TODO: implement initState
    projectNameInputController = new TextEditingController();

    projectPriceInputController = new TextEditingController();

    super.initState();
  }

  void createRecord() async {
    FirebaseUser currentUser= await FirebaseAuth.instance.currentUser();
    if(_productInputFormKey.currentState.validate()){
      await databaseReference.collection("Product")
          .document()

          .setData({
        'Product name': projectNameInputController.text,
        'Product Price': projectPriceInputController.text,
        'Delivry Date': formattedDate,
        'uid': currentUser.uid
      }).then((value) {
        projectNameInputController.clear();
        projectPriceInputController.clear();
      });


      print(currentUser.uid + "      Record added");
      showDialog(context: context,
      builder: (BuildContext context){
        return AlertDialog(title: Text(projectNameInputController.text),
          content: Text("Added successfully"),) ;
      });

    }
    }



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.0),
      child: Column(

        children: <Widget>[
          CardContentTitle(
            title: "Add Order",
            content: _BuildContent(context),
          ),
          CardContentTitle(
            title: "Order List",
            content: _orderList(context),
          )

        ],
      ),
    );
  }
  final dateFormat = DateFormat("d-MM-yyyy");
  DateTime date;
  Widget _BuildContent(BuildContext context) {
    return Form(
      key: _productInputFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          TextFormField(
            decoration: InputDecoration(
                labelText: 'Project Name*', hintText: "bannar design"),
            controller: projectNameInputController,
            validator: (value) {
              if (value.length < 3) {
                return "Please enter a valid Project name.";
              }
            },
          ),
          TextFormField(
              decoration: InputDecoration(
                  labelText: 'Project Price*', hintText: "500 usd"),
              controller: projectPriceInputController,
              validator: (value) {
                if (value.length < 3) {
                  return "Please enter a valid Price.";
                }
              }),

    DateTimeField(format: dateFormat,
    decoration: InputDecoration(labelText: 'Delivery Date'),
    keyboardType: TextInputType.datetime,
    onShowPicker: (context, currentValue) {
    return showDatePicker(context: context, initialDate: currentValue ?? DateTime.now(), firstDate: DateTime(2019), lastDate: DateTime(2050));

    },
    onChanged: (dt) {
    setState(() {
    date=dt ;
    formattedDate = "${date.day}-${date.month}-${date.year}";

    // Customer(dateSelectecInput: formattedDate,);

    });
    },
    ),

          RaisedButton(onPressed: () { createRecord();},child: Text("Add"),color: Colors.green,),



        ],
      ),
    );
  }

  Widget _orderList(BuildContext context){
    return OrderList();

  }

}
