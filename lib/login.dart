import 'package:dairy/admin_dashboard.dart';
import 'package:dairy/Farmer/farmer_dashboard.dart';
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
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

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
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
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
                'Login',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
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
                  contentPadding: const EdgeInsets.only(top: 5, left: 35),
                  hintText: 'Enter the Email',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
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
                  contentPadding: const EdgeInsets.only(top: 5, left: 35),
                  hintText: 'Enter the Password',
                  hintStyle: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
            const SizedBox(
              height: 80,
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
              margin:
                  const EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 5),
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
              margin:
                  const EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 5),
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
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                await logIn();
                if (_value == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminDashboard()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FarmerDashboard()));
                }
              },
              child: Center(
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xFF20BCDE),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 28),
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
                              builder: (context) => RegistrationScreen()));
                    },
                    child: const Text(
                      ' Register',
                      style: TextStyle(color: Color(0xFF20BCDE)),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
