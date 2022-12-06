import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckStatus extends StatefulWidget {
  const CheckStatus({Key? key}) : super(key: key);

  @override
  State<CheckStatus> createState() => _CheckStatusState();
}

class _CheckStatusState extends State<CheckStatus> {
  final User? user = FirebaseAuth.instance.currentUser;

  var name;
  var email;
  var shift;
  var location;
  var status;
  var date;

  readData() async {
    var collection = FirebaseFirestore.instance.collection('pickup-request');
    var docSnapshot = await collection.doc(user?.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        name = data?['name'];
        email = data?['email'];
        shift = data?['shift'];
        location = data?['location'];
        status = data?['status'];
        date = data?['date'];
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
      appBar: AppBar(
        title: Text('Status'),
        actions: [
          IconButton(
              onPressed: () async {
                await readData();
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Column(
        children: [
          Text('$name\n$email\n$shift\n$date'),
          status == 'Pending'
              ? Icon(
                  Icons.pending_actions,
                  color: Colors.yellow[800],
                )
              : status == 'Accepted'
                  ? Icon(
                      Icons.done,
                      color: Colors.green,
                    )
                  : Icon(
                      Icons.cancel,
                      color: Colors.red,
                    )
        ],
      ),
    );
  }
}
