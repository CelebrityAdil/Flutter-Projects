import 'package:flutter/material.dart';

class Alertdialog extends StatefulWidget {
  const Alertdialog({super.key});

  @override
  _AlertDialog createState() => _AlertDialog();
}

class _AlertDialog extends State<Alertdialog> {
  Future<void> showAlertdialog() async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[800],
          title: Text(
            "Simple Alert Dialog",
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  "Google is not working!!",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "Ok",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Alret Dialogue"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showAlertdialog();
              },
              child: Text("Display simple Dialogue"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AdvancedAlertDialog();
                  },
                );
              },
              child: Text("Display custom Dialogue"),
            ),
          ],
        ),
      ),
    );
  }
}

class AdvancedAlertDialog extends StatelessWidget {
  const AdvancedAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 70, 10, 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Adil is just for world innovation",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // closes the dialog
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2f8d46), // ✅ updated
                      ),
                      child: const Text(
                        "Ok",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: -60,
            child: CircleAvatar(
              backgroundColor: Colors.green,
              radius: 40,
              child: Image.network(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRGHnbiOBlrzh8m4dEMh6TAd-bAc5JeXkzllg&s",
                height: 70,
                width: 70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
