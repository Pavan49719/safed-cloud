import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class FarmerHistory extends StatefulWidget {
  const FarmerHistory({Key? key}) : super(key: key);

  @override
  State<FarmerHistory> createState() => _FarmerHistoryState();
}

class _FarmerHistoryState extends State<FarmerHistory> {
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: eventTab()
    );
  }
}

Widget eventTab() {
  return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        // String dtime =
        // timeAgoSinceDate('');
        return Card(
          child: GFListTile(
              color: Colors.transparent,
              avatar: GFAvatar(
                child: const Icon(
                  Icons.add_alert,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'Id',
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              subTitle: Padding(
                padding: const EdgeInsets.only(top: 2.50),
                child: Text(
                  'Zone Name | ',
                ),
              ),
              icon: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.announcement,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SimpleDialog(
                            title: const Text('MetaData'),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Event Occurrence Time:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Updated Date:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Created Date: '),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Zone Name: '),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Panel Number:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Event Name: '),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Event Code:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Severity Name: '),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Status Name: '),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Event Type Id: '),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Panel Name:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Site Name: '),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Zone Event Transaction Id:'),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Full Time:'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  // Text(dtime),
                ],
              )),
        );
      });
}