import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/controller/FirebaseService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseService service = FirebaseService();
  final TextEditingController _controller = TextEditingController();
  Set<String> selectedItems = {};

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
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 229, 229, 229),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ]),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        labelText: 'Enter name',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      service.addData(_controller.text);
                      _controller.clear();
                    }
                    Get.snackbar('Send', "Data Add Sucsessfully");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    minimumSize: const Size(80, 55),
                  ),
                  child: const Text('Send'),
                ),
              ],
            ),
            const SizedBox(
              height: 26,
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

                      bool isSelected = selectedItems.contains(doc.id);

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          selected: isSelected,
                          selectedTileColor: Colors.purple[300],
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          iconColor: Colors.white,
                          textColor: Colors.white,
                          tileColor: isSelected
                              ? Colors.purple[300]
                              : Colors.purple, // Toggle color

                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedItems.remove(doc.id); // Deselect
                              } else {
                                selectedItems.add(doc.id); // Select
                              }
                            });
                          },
                          leading: IconButton(
                            onPressed: () {
                              service.deleteData(doc.id);
                              Get.snackbar(
                                  'Delete', "Data Deleted Sucsessfully");
                            },
                            icon: const Icon(Icons.delete),
                          ),
                          title: Text(
                            name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
                                          if (updateController
                                              .text.isNotEmpty) {
                                            service.updateData(
                                                doc.id, updateController.text);
                                            Navigator.of(context).pop();
                                          }
                                          Get.snackbar('Updated',
                                              "Data Updated Sucsessfully");
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
