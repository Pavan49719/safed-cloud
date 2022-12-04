// register
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

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
  TextEditingController locationc = TextEditingController();

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

  Future createUser() async {
    try {
      final docUser = FirebaseFirestore.instance
          .collection('importers')
          .doc(email.text.trim());
      final json = {
        'email': email.text.trim(),
        'name': name.text.trim(),
        'location': locationc.text.trim(),
      };

      await docUser.set(json);
    } catch (e) {
      print(e);
    }
  }

  Future createExporterUser() async {
    try {
      final docUser = FirebaseFirestore.instance
          .collection('exporters')
          .doc(email.text.trim());
      final json = {
        'email': email.text.trim(),
        'name': name.text.trim(),
        'location': locationc.text.trim(),
      };

      await docUser.set(json);
    } catch (e) {
      print(e);
    }
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address =
    '${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {
      locationc = Address as TextEditingController;
    });
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
            Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              height: 35,
              child: Material(
                elevation: 2.0,
                borderRadius: BorderRadius.circular(22.0),
                child: TextFormField(
                  controller:  locationc..text = '$Address',
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
                    hintText: 'Location',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    suffix: GestureDetector(
                      onTap: () async {
                        _getGeoLocationPosition();
                        Position position = await _getGeoLocationPosition();
                        location =
                            'Lat: ${position.latitude} , Long: ${position.longitude}';
                        GetAddressFromLatLong(position);
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: RichText(
                          text: const TextSpan(children: [
                            TextSpan(
                                text: 'Detect Automatically',
                                style: TextStyle(
                                    color: Color(0xFF20BCDE),
                                    decoration: TextDecoration.underline)),
                            WidgetSpan(
                              child: Icon(
                                Icons.gps_fixed,
                                color: Color(0xFF20BCDE),
                                size: 14,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  style: TextStyle(color: Colors.grey[900]),
                ),
              ),
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
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                await signUp();
                await createUser();
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
