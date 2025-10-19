import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdTodo extends StatefulWidget {
  const AdTodo({super.key});

  @override
  State<AdTodo> createState() => _AdTodoState();
}

class _AdTodoState extends State<AdTodo> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  Future<void> addToDatabase() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;

    if (user == null) {
      Fluttertoast.showToast(msg: "You must be logged in to add a task");
      return;
    }

    final uid = user.uid;
    var time = DateTime.now();

    await FirebaseFirestore.instance
        .collection('tasks') // ✅ changed from 'task' to 'tasks'
        .doc(uid)
        .collection('usertask')
        .doc(time.toString())
        .set({
          'title': titlecontroller.text,
          'description': descriptioncontroller.text,
          'time': time.toString(),
        });

    Fluttertoast.showToast(msg: "Task added successfully");
    Navigator.pop(context); // ✅ Go back to Home after adding
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[700],
        title: Text("Add To Do"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(height: 40),
            Text(
              "Add the task to do",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 50),
            TextField(
              controller: titlecontroller,
              decoration: InputDecoration(
                labelText: "Title",
                labelStyle: TextStyle(color: Colors.grey.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptioncontroller,
              decoration: InputDecoration(
                labelText: "Description",
                labelStyle: TextStyle(color: Colors.grey.shade700),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade300,
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                onPressed: () {
                  if (titlecontroller.text.isEmpty ||
                      descriptioncontroller.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please fill in all fields");
                  } else {
                    addToDatabase();
                  }
                },
                child: Text("Add Todo"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
