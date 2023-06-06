// register
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dairy/admin/admin_dashboard.dart';
import 'package:dairy/Farmer/farmer_dashboard.dart';
import 'package:dairy/importer/importer_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var _value;
  String location = 'Null, Press Button';
  String Address = '';
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future signUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
        
      );
    } catch (e) {
      print(e);
    }
  }

  Future createFarmerUser() async {
    try {
      final docUser = FirebaseFirestore.instance
          .collection('farmers')
          .doc(email.text.trim());
      final json = {
        'email': email.text.trim(),
        'name': name.text.trim(),
        'phoneno':'',
        'aadhar':'',
        'acc-no':'',
        'age':'',
        'ifsc-code':'',
        'location':'',
      };

      await docUser.set(json);
    } catch (e) {
      print(e);
    }
  }

  Future createAdminUser() async {
    try {
      final docUser =
          FirebaseFirestore.instance.collection('admin').doc(email.text.trim());
      final json = {
        'email': email.text.trim(),
        'name': name.text.trim(),
      };

      await docUser.set(json);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Text(
                'Register',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              height: 35,
              decoration: const BoxDecoration(),
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(22.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    filled: true,
                    fillColor: Colors.transparent,
                    contentPadding: const EdgeInsets.only(top: 5, left: 35),
                    hintText: 'Enter the Name',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              height: 35,
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(22.0),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    contentPadding: const EdgeInsets.only(top: 5, left: 35),
                    hintText: 'Enter the email',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              height: 35,
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(22.0),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 0.0,
                      ),
                      borderRadius: BorderRadius.circular(22.0),
                    ),
                    contentPadding: const EdgeInsets.only(top: 5, left: 35),
                    hintText: 'Enter the Password',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                  ),
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            const SizedBox(
              height: 25,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              child: Text('Please Select Your Profile',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(left: 25, right: 25),
              height: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade600),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Dairy Collector',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                  Radio(
                    toggleable: true,
                    value: 1,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFF20BCDE)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.only(left: 25, right: 25),
              height: 70,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade600),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Farmer',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                  Radio(
                    toggleable: true,
                    value: 2,
                    groupValue: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                    fillColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xFF20BCDE)),
                  ),
                ],
              ),
            ),
            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Importer',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                )),
                            Radio(
                              toggleable: true,
                              value: 3,
                              groupValue: _value,
                              onChanged: (value) {
                                setState(() {
                                  _value = value;
                                });
                              },
                              fillColor: MaterialStateColor.resolveWith(
                                  (states) => const Color(0xFF20BCDE)),
                            ),
                          ],
                        ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await signUp();
                if (_value == 1) {
                  await createAdminUser();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminDashboard()));
                } else if(_value==2) {
                  await createFarmerUser();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FarmerDashboard()));
                } else{
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ImporterDashboard()));
                }
              },
              child: Center(
                child: Container(
                  width: 170,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xFF20BCDE),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Center(
                      child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  )),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Already a User?',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                      onTap: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Color(0xFF20BCDE)),
                      )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
