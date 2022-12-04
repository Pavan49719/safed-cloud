import 'package:dairy/Farmer/farmer_profile.dart';
import 'package:flutter/material.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({Key? key}) : super(key: key);

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FarmerProfile()));
              }, child: Text('My Profile')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {}, child: Text('Fill Details')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {}, child: Text('Pickup Request')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {}, child: Text('Milk Rate')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {}, child: Text('My Wallet')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {}, child: Text('My Daily Collection')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {}, child: Text('Instruction')),
              SizedBox(height: 10,),

            ],
          ),
        ),
      ),
    );
  }
}
