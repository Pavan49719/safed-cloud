import 'package:dairy/admin/addmilk.dart';
import 'package:dairy/admin/farmersdet.dart';
import 'package:dairy/admin/history.dart';
import 'package:dairy/admin/tenderslists.dart';
import 'package:dairy/admin/orders.dart';
import 'package:dairy/admin/setprice.dart';
import 'package:dairy/importer/newtender.dart';
import 'package:dairy/importer/tenderslist.dart';
import 'package:flutter/material.dart';

class ImporterDashboard extends StatefulWidget {
  const ImporterDashboard({Key? key}) : super(key: key);

  @override
  State<ImporterDashboard> createState() => _ImporterDashboardState();
}

class _ImporterDashboardState extends State<ImporterDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Importer\'s Dashboard'),
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
                        'Create new tender',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => NewTender()));
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TendersList()));
              },
            ),
          ],
        ),
      ]),
    );
  }
}
