import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:canary_admin/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class UserProfile extends StatefulWidget{
  String uid;
  UserProfile({Key key,this.uid});
  @override
   _UserProfileState createState() => _UserProfileState();

}

class _UserProfileState extends State<UserProfile>{


  @override
  void initState() {
    // TODO: implement initState

  }


  /*_UserProfileState(){
    getData().then((value) => setState((){
      userData=value;
      print(userData);
    }));
  }*/
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(

      padding: EdgeInsets.all(10.0),

      child: Column(
        children: <Widget>[

          SizedBox(height: 30.0,),
          FlatButton(onPressed: (){
            FirebaseAuth.instance
                .signOut()
                .then((result) =>
                Navigator.pushReplacementNamed(context, "/login"))
                .catchError((err) => print(err));

          }, child: Text("Log out"),color: Colors.blueAccent,
          ),
          SizedBox(height: 30.0,),

          // BookList(),
          FlatButton(

            color: Colors.pinkAccent,
            onPressed: () async{
              var firebaseUser = await FirebaseAuth.instance.currentUser();
              Firestore.instance.collection("List").document(firebaseUser.uid).get().then((value){
                //print(value.data);

                print(value.data);
              });
            },
          ),


          SizedBox(height: 30.0,),

           BookList(),


          //UserDetails(),

        ],
      ),

    );
  }

}

class BookList extends StatefulWidget {


   @override
   _BookListState createState() => _BookListState();
}
class _BookListState extends State<BookList>{

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
   return StreamBuilder<QuerySnapshot>(
     stream: Firestore.instance
         .collection('List')
          .where('uid', isEqualTo: userId)
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

                       new Text('Name:',style: TextStyle(fontSize: 28.0,
                           color: Colors.blueAccent,fontWeight: FontWeight.bold),
                       ),
                       SizedBox(width: 15.0,),
                       Text(document['fname'],style: TextStyle(
                           fontSize: 28.0,color: Colors.lightBlue,fontStyle: FontStyle.italic
                       ),),
                       SizedBox(width: 15.0,),
                       Text(document['surname'],style: TextStyle(
                           fontSize: 28.0,color: Colors.lightBlue,fontStyle: FontStyle.italic
                       ),)
                     ],
                   ),

                   Wrap(
                     direction: Axis.horizontal,
                     children: <Widget>[

                       new Text('Email:',style: TextStyle(fontSize: 28.0,
                           color: Colors.blueAccent,fontWeight: FontWeight.bold),
                       ),
                       SizedBox(width: 15.0,),
                       Text(document['email'],style: TextStyle(
                         fontSize: 28.0,color: Colors.lightBlue,fontStyle: FontStyle.italic
                        ),),
                     ],
                   )


                 ],
               );
             }).toList(),
           );
       }
     },
   );
  }

}
////

/////
class getd extends StatelessWidget {

  Future<FirebaseUser> firebaseUser = FirebaseAuth.instance.currentUser();

  getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userId = user.uid;
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream:
        Firestore.instance.collection('List')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 75.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    snapshot.data.documents[0]['email'],
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child:
                    Text(snapshot.data.documents[0]['fname']),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
/**/
/*

class UserProfile extends StatelessWidget {
  getData()async{
    var firebaseUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("List").document(firebaseUser.uid).get().then((value){
      print(value.data);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(10.0),

      child: Column(
        children: <Widget>[

          SizedBox(height: 30.0,),
          FlatButton(onPressed: (){
            FirebaseAuth.instance
                .signOut()
                .then((result) =>
                Navigator.pushReplacementNamed(context, "/login"))
                .catchError((err) => print(err));

          }, child: Text("Log out"),color: Colors.blueAccent,
          ),
          SizedBox(height: 30.0,),

         // BookList(),
          FlatButton(
            color: Colors.pinkAccent,
            onPressed: () async{
              var firebaseUser = await FirebaseAuth.instance.currentUser();
              Firestore.instance.collection("List").document(firebaseUser.uid).get().then((value){
                print(value.data);
              });
            },
          ),


          //UserDetails(),

        ],
      ),

    );
  }

}


class BookList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('List')
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
                return Column(
                  children: <Widget>[

                    new Text(document['email']),
                    new Text(document['fname']),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }
}
class getd extends StatelessWidget{

Future<FirebaseUser> firebaseUser = FirebaseAuth.instance.currentUser() ;

  getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userId=user.uid;
    return userId;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream:
        Firestore.instance.collection('List')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          return Container(
            child: Padding(
              padding: const EdgeInsets.only(top: 75.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    snapshot.data.documents[0]['email'],
                    style: TextStyle(fontSize: 25.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child:
                    Text(snapshot.data.documents[0]['fname']),
                  ),
                ],
              ),
            ),
          );
        });
  }

}
class UserDetails extends StatelessWidget{
  getCurrentUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    var userId = user.uid;
    return userId.toString();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance

          .collection('List')
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
                return Column(
                  children: <Widget>[

                    new Text(document['email']),
                    new Text(document['fname']),
                  ],
                );
              }).toList(),
            );
        }
      },
    );
  }

*/
