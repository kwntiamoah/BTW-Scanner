import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanner_app/config/colors.dart';

class Error extends StatelessWidget {
  final String message;
  const Error({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/error.json'),
            Text(message, style: const TextStyle(fontSize: 16)),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Try Again'),
              style: ElevatedButton.styleFrom(primary: KColors.primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
