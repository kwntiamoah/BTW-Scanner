import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanner_app/config/colors.dart';

class Success extends StatelessWidget {
  const Success({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/success.json'),
            const Text('Scan Successful', style: TextStyle(fontSize: 18),),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Scan Again'),
              style: ElevatedButton.styleFrom(primary: KColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
