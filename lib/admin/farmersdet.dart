import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class FarmDet extends StatefulWidget {
  const FarmDet({Key? key}) : super(key: key);

  @override
  State<FarmDet> createState() => _FarmDetState();
}

class _FarmDetState extends State<FarmDet> {
  List<DocumentSnapshot>? documents;
  int? Count;

  readData() async {
    final _firestore = FirebaseFirestore.instance;
    final QuerySnapshot result = await _firestore.collection('farmers').get();
    setState(() {
      documents = result.docs;
      Count = documents?.length;
    });
    print("DATA IS: ${documents?.length}");
    print("DATA IS: ${documents![1]['date']}");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer\'s details'),
      ),
      body: Count != null
          ? ListView.builder(
              itemCount: Count,
              itemBuilder: (BuildContext context, int index) {
                // String dtime =
                // timeAgoSinceDate('');
                return Card(
                  child: GFListTile(
                      color: Colors.transparent,
                      avatar: const GFAvatar(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        '${documents?[index]['name']}',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subTitle: Padding(
                        padding: const EdgeInsets.only(top: 2.50),
                        child: Text(
                          'Location: ${documents?[index]['location']}',
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
                                    title: const Text('More Information'),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Name: ${documents?[index]['name']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Location: ${documents?[index]['location']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Age: ${documents?[index]['age']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Phone: ${documents?[index]['phoneno']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Aadhar no.:${documents?[index]['aadhar']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Account no.:${documents?[index]['acc-no']}'),
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
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}
