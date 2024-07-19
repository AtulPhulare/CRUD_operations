import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final CollectionReference data =
      FirebaseFirestore.instance.collection('userdata');
  final TextEditingController _controller = TextEditingController();

  Future<void> addData(String name) {
    return data.add({
      'name': name,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getData() {
    return data.snapshots();
  }

  Future<void> deleteData(String docId) {
    return data.doc(docId).delete();
  }

  Future<void> updateData(String docId, String newName) {
    return data.doc(docId).update({
      'name': newName,
      'timestamp': Timestamp.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Operations'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter name',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                addData(_controller.text);
                _controller.clear();
              }
            },
            child: const Text('Send'),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: getData(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No data available'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    var data = doc.data() as Map<String, dynamic>;
                    var name = data['name'];

                    return ListTile(
                      leading: IconButton(
                        onPressed: () {
                          deleteData(doc.id);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      title: Text(name),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              var updateController =
                                  TextEditingController(text: name);
                              return AlertDialog(
                                title: const Text('Update Name'),
                                content: TextField(
                                  controller: updateController,
                                  decoration: const InputDecoration(
                                      labelText: 'Enter new name'),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      if (updateController.text.isNotEmpty) {
                                        updateData(
                                            doc.id, updateController.text);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('Update'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
