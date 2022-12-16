import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<DocumentSnapshot>? documents;
  int? Count;

  readData() async {
    final _firestore = FirebaseFirestore.instance;
    final QuerySnapshot result = await _firestore.collection('history').get();
    setState(() {
      documents = result.docs;
      Count = documents?.length;
    });
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
        title: Text('History'),
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
                          'Date: ${documents?[index]['date']}',
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
                                            'date: ${documents?[index]['date']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Phone no: ${documents?[index]['phoneno']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Shift: ${documents?[index]['shift'] == 1 ? 'Morning' : 'Evening'}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Type.:${documents?[index]['Type'] == 1 ? 'Cow' : 'Buffalo'}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Fat:${documents?[index]['Fat']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Snf:${documents?[index]['Snf']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Quantity:${documents?[index]['Quantity']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Rate:${documents?[index]['Rate']}'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            'Total:${documents?[index]['Total']}'),
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
