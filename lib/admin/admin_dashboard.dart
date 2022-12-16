import 'package:dairy/admin/addmilk.dart';
import 'package:dairy/admin/farmersdet.dart';
import 'package:dairy/admin/makepayments.dart';
import 'package:dairy/admin/milkcollection.dart';
import 'package:dairy/admin/orders.dart';
import 'package:dairy/admin/setprice.dart';
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
      body: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    Icon(Icons.grass),
                    Text('Farmer\'s detail'),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FarmDet()));
              },
            ),
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    Icon(Icons.checklist_rtl),
                    Text('Orders'),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Orders()));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    Icon(Icons.plus_one),
                    Text('Add Milk'),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Scanner()));
              },
            ),
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    Icon(Icons.price_change),
                    Text('Set Milk Price'),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SetMilkPrice()));
              },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Container(
                padding: EdgeInsets.all(14),
                child: Column(
                  children: [
                    Icon(Icons.price_change),
                    Text('Make Payments'),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MakePayments()));
              },
            ),
          ],
        )
      ]),
    );
  }
}
