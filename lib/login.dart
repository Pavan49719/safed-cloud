import 'package:dairy/admin/admin_dashboard.dart';
import 'package:dairy/Farmer/farmer_dashboard.dart';
import 'package:dairy/importer/importer_dashboard.dart';
import 'package:dairy/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _value;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future logIn() async {
    // showDialog(
    //   context: context,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(
        child: Stack(children: [
          Column(
            children: [
              Container(
                height: 200,
                color: Colors.blueAccent,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 130, vertical: 80),
                        child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        height: 35,
                        child: TextField(
                          controller: email,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding:
                                const EdgeInsets.only(top: 5, left: 35),
                            hintText: 'Enter the Email',
                            hintStyle: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 25, right: 25),
                        height: 35,
                        child: TextField(
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(22.0),
                                borderSide: BorderSide.none),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding:
                                const EdgeInsets.only(top: 5, left: 35),
                            hintText: 'Enter the Password',
                            hintStyle: TextStyle(color: Colors.grey[700]),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        child: Text('Please Select Your Profile',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                            )),
                      ),
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(
                            top: 5, left: 25, right: 25, bottom: 5),
                        height: 75,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Dairy Admin',
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
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(
                            top: 5, left: 25, right: 25, bottom: 5),
                        height: 75,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
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
                      Container(
                        padding: const EdgeInsets.all(15),
                        margin: const EdgeInsets.only(
                            top: 5, left: 25, right: 25, bottom: 5),
                        height: 75,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8)),
                        child: Row(
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
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await logIn();
                          if (_value == 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdminDashboard()));
                          } else if (_value == 2) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FarmerDashboard()));
                          } else if (_value == 3) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImporterDashboard()));
                          }
                        },
                        child: Center(
                          child: Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                                color: const Color(0xFF20BCDE),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 28),
                              ),
                            ),
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
                              'New User?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RegistrationScreen()));
                              },
                              child: const Text(
                                ' Register',
                                style: TextStyle(color: Color(0xFF20BCDE)),
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 120),
            child: Center(
              child: Container(
                  width: 150,
                  height: 150,
                  child: Image.asset("assets/login.png")),
            ),
          ),
        ]),
      ),
    );
  }
}
