import 'package:flutter/material.dart';

class FarmerProfile extends StatefulWidget {
  const FarmerProfile({Key? key}) : super(key: key);

  @override
  State<FarmerProfile> createState() => _FarmerProfileState();
}

class _FarmerProfileState extends State<FarmerProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Container(
                height: 100,
                width: 100,
                child: Text('QR code'),
              ),
            SizedBox(height: 10,),
            Container(
              height: 100,
              width: 200,
              child: Text('Name'),
            ),
            SizedBox(height: 10,),
            Container(
              height: 100,
              width: 200,
              child: Text('Phone Number'),
            ),
            SizedBox(height: 10,),
            Center(
                child: GestureDetector(
                  onTap: (){
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 28),
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
