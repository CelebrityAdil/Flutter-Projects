import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class authform extends StatefulWidget {
  const authform({super.key});

  @override
  State<authform> createState() => _authformState();
}

class _authformState extends State<authform> {
  final _formkey = GlobalKey<FormState>();
  var _email = "";
  var _password = "";
  var _username = "";
  bool _isLogin = true;

  Future<void> startAuthentication() async {
    final isValid = _formkey.currentState!
        .validate(); // Use currentState instead of currentContext
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formkey.currentState!.save();
      await submitform(_username, _email, _password);
    }
  }

  submitform(String username, String email, String password) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;

    try {
      if (_isLogin) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      } else {
        final authResult = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = authResult.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': username,
          'email': email,
        });
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!_isLogin)
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.length < 7) {
                          return "Enter a valid username!!";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!;
                      },
                      key: ValueKey('username'),
                      decoration: InputDecoration(
                        labelText: "Username",
                        hintText: "Enter user name",
                        labelStyle: GoogleFonts.roboto(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty || value.contains("2")) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },

                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('email'),
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: ("Enter your email"),
                        labelStyle: GoogleFonts.roboto(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 7) {
                        return "Please enter correct password";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },

                    keyboardType: TextInputType.emailAddress,
                    key: ValueKey('password'),
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: ("Enter your password"),
                      labelStyle: GoogleFonts.roboto(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 60,
                    width: double.infinity,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          76,
                          161,
                          230,
                        ),
                      ),
                      onPressed: () {
                        startAuthentication();
                      },
                      child: Text(
                        _isLogin ? "Login" : "signup",
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 19,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(
                        _isLogin
                            ? "Create an account"
                            : "Already have an account",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
