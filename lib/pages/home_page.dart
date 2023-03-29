import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetutorial/read%20data/get_user_name.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  // document ID
  List<String> docIds = [];

  // get document ID
  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        // docIds.add(element.id);
        print(element.reference);
        docIds.add(element.id);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(Icons.person),
        title: Text("${user?.email}"),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: FutureBuilder(
            future: getDocIds(),
            builder: (context, snapshot) {
              return ListView.builder(
                  itemCount: docIds.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          leading: const Icon(Icons.person),
                          tileColor: Colors.grey[200],
                          title: GetUserName(documentId: docIds[index])),
                    );
                  }));
            },
          )),
        ],
      )),
    );
  }
}
