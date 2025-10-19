import 'package:flutter/material.dart';
import 'package:todo_app/pages/authform.dart';

class authscreen extends StatefulWidget {
  const authscreen({super.key});

  @override
  State<authscreen> createState() => _authscreenState();
}

class _authscreenState extends State<authscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Auth Screen")),
      body: authform(),
    );
  }
}
