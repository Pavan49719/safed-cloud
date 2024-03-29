import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairy/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  var phno;

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
        phno = data?['phoneno'];
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
        child: name != null
            ? SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      child: Container(
                        height: 250,
                        width: 250,
                        child: GenerateQR(phno),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.cyan,
                      child: Container(
                        height: 50,
                        width: 350,
                        child: Center(
                            child: Text(
                          'Name : $name',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.cyan,
                      child: Container(
                        height: 50,
                        width: 350,
                        child: Center(
                            child: Text(
                          'Phone no : $phno',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.cyan,
                      child: Container(
                        height: 50,
                        width: 350,
                        child: Center(
                            child: Text(
                          'Account no : $accno',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.cyan,
                      child: Container(
                        height: 50,
                        width: 350,
                        child: Center(
                            child: Text(
                          'Location : $location',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      color: Colors.cyan,
                      child: Container(
                        height: 50,
                        width: 350,
                        child: Center(
                            child: Text(
                          'Aadhar no : $aadhar',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Center(
                        child: GestureDetector(
                      onTap: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                        } catch (e) {
                          print(e);
                        }
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        'Logout',
                        style:
                            TextStyle(color: Colors.blueAccent, fontSize: 28),
                      ),
                    )),
                  ],
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

class GenerateQR extends StatefulWidget {
  String phno;
  GenerateQR(this.phno);

  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  final qrdataFeed = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        //Scroll view given to Column
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QrImage(data: widget.phno),
          ],
        ),
      ),
    );
  }
}
