import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/controller/FirebaseService.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseService service = FirebaseService();
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Operations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Enter name',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  service.addData(_controller.text);
                  _controller.clear();
                }
              },
              child: const Text('Send'),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: service.getData(),
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
                            service.deleteData(doc.id);
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
                                          service.updateData(
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
      ),
    );
  }
}
