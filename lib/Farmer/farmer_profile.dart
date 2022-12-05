import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FarmerProfile extends StatefulWidget {
  const FarmerProfile({Key? key}) : super(key: key);

  @override
  State<FarmerProfile> createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {
  final User? user = FirebaseAuth.instance.currentUser;

  var name;
  var email;
  var accno;
  var location;
  var aadhar;

  readData() async {
    var collection = FirebaseFirestore.instance.collection('farmers');
    var docSnapshot = await collection.doc(user?.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        name = data?['name'];
        email = data?['email'];
        accno = data?['acc-no'];
        location = data?['location'];
        aadhar = data?['aadhar'];
      });
      // <-- The value you want to retrieve.
      print('DATA: $data');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: 
        name!=null?
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              child: Text('QR code'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: 200,
              child: Text('Name : $name'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: 200,
              child: Text('Email : $email'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: 200,
              child: Text('Account no : $accno'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: 200,
              child: Text('Location : $location'),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: 200,
              child: Text('Aadhar no : $aadhar'),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: GestureDetector(
              onTap: () {},
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.blueAccent, fontSize: 28),
              ),
            )),
          ],
        ):CircularProgressIndicator(),
      ),
    );
  }
}
