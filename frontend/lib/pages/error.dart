
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:formula/components/bottomNavBar.dart';
import 'package:formula/general/fonts.dart';
import 'package:formula/general/themes.dart';

class ErrorScreen extends StatelessWidget {
  final String errorDetails;

  const ErrorScreen({
    Key? key,
    required this.errorDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.orange,
        title: const Text('Gas Insurance'),
      ),
      backgroundColor: Colors.transparent,
      bottomNavigationBar: const BottomNavBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15,0,15,20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  'assets/images/error.webp',
                  width: ScreenSize.width * 0.9,  
              ),
              const SizedBox(height: 40,),
              Text(
                errorDetails,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
              const SizedBox(height: 12),
              const Text("Try again later!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}