import 'package:dairy/admin/addmilk.dart';
import 'package:dairy/admin/farmersdet.dart';
import 'package:dairy/admin/history.dart';
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
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade900),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ))),
              child: Container(
                width: 100,
                height: 175,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.grass,
                        size: 60,
                      ),
                      Text(
                        'Farmer\'s \n\t  detail',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FarmDet()));
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ))),
              child: Container(
                width: 100,
                height: 175,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.checklist_rtl,
                      size: 60,
                    ),
                    Text(
                      'Orders',
                      style: TextStyle(fontSize: 20),
                    ),
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
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade900),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ))),
              child: Container(
                width: 100,
                height: 175,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.plus_one,
                      size: 60,
                    ),
                    Text(
                      ' Add \n\tMilk',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Scanner()));
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade600),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ))),
              child: Container(
                width: 100,
                height: 175,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.price_change,
                      size: 60,
                    ),
                    Text(
                      '  Set Milk \n\t   Price',
                      style: TextStyle(fontSize: 20),
                    ),
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
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade800),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ))),
              child: Container(
                width: 100,
                height: 175,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 60,
                    ),
                    Text(
                      '      Milk \n\tCollection',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => History()));
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.green.shade700),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0),
                  ))),
              child: Container(
                width: 100,
                height: 175,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wallet,
                      size: 60,
                    ),
                    Text(
                      '  Make \nPayment',
                      style: TextStyle(fontSize: 20),
                    ),
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
