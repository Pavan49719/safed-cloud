import 'package:dairy/Farmer/farmer_milk_rate.dart';
import 'package:dairy/Farmer/farmer_profile.dart';
import 'package:dairy/Farmer/fill_details.dart';
import 'package:dairy/Farmer/pickup_request.dart';
import 'package:flutter/material.dart';

import 'farmer_history.dart';

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
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FillDetails()));
              }, child: Text('Fill Details')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FarmerPickup()));
              }, child: Text('Pickup Request')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FarmerMilkRate()));
              }, child: Text('Milk Rate')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {

              }, child: Text('My Wallet')),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FarmerHistory()));
              }, child: Text('My Daily Collection')),
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
