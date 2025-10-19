import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/pages/AddTodo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String uid = "";

  @override
  void initState() {
    super.initState();
    getuid();
  }

  getuid() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(child: Container()),
            Text("Todo"),
            Text("List", style: TextStyle(color: Colors.blue.shade300)),
            Expanded(child: Container()),
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                // The StreamBuilder in main.dart will automatically redirect to authscreen
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.exit_to_app),
              ),
            ),
          ],
        ),
      ),
      body: uid.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            ) // ⏳ Show loader until UID is ready
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("tasks") // ✅ match here
                  .doc(uid)
                  .collection("usertask")
                  .snapshots(),

              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text("No tasks yet"));
                }
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final task = snapshot.data!.docs[index];
                    return Card(
                      child: ListTile(
                        title: Text(task['title']),
                        subtitle: Text(task['description']),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('tasks') // ✅ match here too
                                .doc(uid)
                                .collection('usertask')
                                .doc(task.id)
                                .delete();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdTodo()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
