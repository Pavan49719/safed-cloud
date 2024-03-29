import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairy/Farmer/reqstatus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FarmerPickup extends StatefulWidget {
  const FarmerPickup({Key? key}) : super(key: key);

  @override
  State<FarmerPickup> createState() => _FarmerPickupState();
}

class _FarmerPickupState extends State<FarmerPickup> {
  var _sValue;
  var _pValue;
  var _mValue;
  String dropdownvalue = 'Katraj Dairy';
  var fname;
  var femail;
  var flocation;
  var fphno;
  String? sdate;
  var items = ['Katraj Dairy', 'AMUL Dairy'];
  TextEditingController dateController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  Future addRequest() async {
    final docUser = FirebaseFirestore.instance
        .collection('pickup-request')
        .doc(user?.email);

    var collection = FirebaseFirestore.instance.collection('farmers');
    var docSnapshot = await collection.doc(user?.email).get();
    if (docSnapshot.exists) {
      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        fname = data?['name'];
        femail = data?['email'];
        flocation = data?['location'];
        fphno = data?['phoneno'];
      });

      final json = {
        'name': fname,
        'email': femail,
        'location': flocation,
        'date': sdate,
        'shift': _sValue == 1 ? 'Morning' : 'Evening',
        'payment-mode': _pValue == 1 ? 'Online' : 'Offline',
        'mode': _mValue == 1 ? 'Weekly' : 'Biweekly',
        'status': 'Pending',
        'phoneno': fphno,
      };
      await docUser.set(json, SetOptions(merge: true));
    }
  }

  @override
  void initState() {
    dateController.text = ""; //set the initial value of text field
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Pickup Request"),
          actions: [
            IconButton(
                icon: Icon(Icons.history),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CheckStatus()));
                })
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.all(15),
                height: 150,
                child: Center(
                    child: TextField(
                  controller:
                      dateController, //editing controller of this TextField
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Enter Date" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(), //get today's date
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(
                          pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(
                          formattedDate); //formatted date output using intl package =>  2022-07-04
                      //You can format date as per your need

                      setState(() {
                        dateController.text = formattedDate;
                        sdate =
                            formattedDate; //set foratted date to TextField value.
                      });
                      print("Date: $sdate");
                    } else {
                      print("Date is not selected");
                    }
                  },
                ))),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Shift:',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  // margin: const EdgeInsets.only(
                  //     top: 5, left: 5, right: 5, bottom: 5),
                  // height: 75,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Morning',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      Radio(
                        toggleable: true,
                        value: 1,
                        groupValue: _sValue,
                        onChanged: (value) {
                          setState(() {
                            _sValue = value;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xFF20BCDE)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  // margin: const EdgeInsets.only(
                  //     top: 5, left: 55, right: 5, bottom: 5),
                  // height: 75,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Evening',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      Radio(
                        toggleable: true,
                        value: 2,
                        groupValue: _sValue,
                        onChanged: (value) {
                          setState(() {
                            _sValue = value;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xFF20BCDE)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Payment:',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  // margin: const EdgeInsets.only(
                  //     top: 5, left: 5, right: 5, bottom: 5),
                  // height: 75,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Online',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      Radio(
                        toggleable: true,
                        value: 1,
                        groupValue: _pValue,
                        onChanged: (value) {
                          setState(() {
                            _pValue = value;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xFF20BCDE)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  // margin: const EdgeInsets.only(
                  //     top: 5, left: 55, right: 5, bottom: 5),
                  // height: 75,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Offline',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      Radio(
                        toggleable: true,
                        value: 2,
                        groupValue: _pValue,
                        onChanged: (value) {
                          setState(() {
                            _pValue = value;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xFF20BCDE)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    'Mode:',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  // margin: const EdgeInsets.only(
                  //     top: 5, left: 5, right: 5, bottom: 5),
                  // height: 75,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Weekly',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      Radio(
                        toggleable: true,
                        value: 1,
                        groupValue: _mValue,
                        onChanged: (value) {
                          setState(() {
                            _mValue = value;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xFF20BCDE)),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  // margin: const EdgeInsets.only(
                  //     top: 5, left: 55, right: 5, bottom: 5),
                  // height: 75,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Biweekly',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          )),
                      Radio(
                        toggleable: true,
                        value: 2,
                        groupValue: _mValue,
                        onChanged: (value) {
                          setState(() {
                            _mValue = value;
                          });
                        },
                        fillColor: MaterialStateColor.resolveWith(
                            (states) => const Color(0xFF20BCDE)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'Select Center',
                    style: TextStyle(color: Colors.black, fontSize: 24),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                await addRequest();
                Navigator.pop(context);
              },
              child: Center(
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xFF20BCDE),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Send Request',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
