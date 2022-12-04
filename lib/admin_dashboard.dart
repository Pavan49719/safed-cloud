import 'package:flutter/material.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin\'s Dashboard'),
      ),
      body: Column(children: [
        Row(
          children: [
            ElevatedButton(
      child: Container(
        child: Column(
          children: [
            Icon(Icons.grass),
            Text('Farmer\'s detail'),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>))
      },
    ),
    ElevatedButton(
      child: Container(
        child: Column(
          children: [
            Icon(Icons.checklist_rtl),
            Text('Orders'),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>))
      },
    ),
          ],
        ),
        Row(
          children: [
            ElevatedButton(
      child: Container(
        child: Column(
          children: [
            Icon(Icons.plus_one),
            Text('Add Milk'),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>))
      },
    ),
    ElevatedButton(
      child: Container(
        child: Column(
          children: [
            Icon(Icons.price_change),
            Text('Set Milk Price'),
          ],
        ),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>))
      },
    ),
    
          ],
        )
      ]),
    );
  }
}


