import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tyamo",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF000221),

        centerTitle: true,
      ),
      body: Column(children: [
        Column(
          children: [
            SizedBox(height: 60,),
            Text(
          "Sign",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        )

          ],
        )
        
      ],),
    );
  }
}
