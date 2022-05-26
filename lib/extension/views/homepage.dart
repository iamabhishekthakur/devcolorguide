import 'package:flutter/material.dart';

class ExtensionHomepage extends StatefulWidget {
  const ExtensionHomepage({Key? key}) : super(key: key);

  @override
  State<ExtensionHomepage> createState() => _ExtensionHomepageState();
}

class _ExtensionHomepageState extends State<ExtensionHomepage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: Text("Extension"),
      ),
    );
  }
}
