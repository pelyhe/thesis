import 'package:flutter/material.dart';
import 'package:formula/general/utils.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBody(
        context: context,
        mobileBody: Container(color: Colors.amber),
        tabletBody: Container(color: Colors.black),
        desktopBody: Container(
          color: Colors.blue,
        ),
      ),
    );
  }
}
