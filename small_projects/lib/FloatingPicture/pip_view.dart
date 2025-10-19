import 'package:flutter/material.dart';
import 'package:pip_view/pip_view.dart';

class Pip extends StatefulWidget {
  const Pip({super.key});

  @override
  State<Pip> createState() => _PipViewState();
}

class _PipViewState extends State<Pip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Picture Floating")),
      body: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PIPView(
      builder: (context, isFloating) {
        return Scaffold(
          resizeToAvoidBottomInset: !isFloating,
          body: Center(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 100),
                  Center(child: Text("This is the pip window")),
                  SizedBox(height: 50),
                  MaterialButton(
                    onPressed: () {
                      PIPView.of(context)?.presentBelow(backgroundscreen());
                    },
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      "Start Floating",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class backgroundscreen extends StatelessWidget {
  const backgroundscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Center(child: Text("This is the background screen")),
        ),
      ),
    );
  }
}
