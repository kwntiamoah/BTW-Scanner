import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanner_app/config/colors.dart';
import 'package:scanner_app/screens/scanner.dart';

class NotFound extends StatelessWidget {
  final String description;
  final String userId;

  const NotFound({Key? key, required this.description, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('QR Scanner', style: TextStyle(fontSize: 16)),
          backgroundColor: KColors.primaryColor, automaticallyImplyLeading: false),
        body: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/lottie/error.json', height: 250),
              Text(
              description
            ),
              SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 26),
                width: double.infinity,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                Scanner(userId: userId)),
                            (route) => false);
                  },
                  label: const Text('Rescan'),
                  icon: const Icon(Icons.qr_code_scanner_rounded),
                  style: ElevatedButton.styleFrom(primary: KColors.primaryColor),
                ),
              )
            ],
          ),
        ),
    );
  }
}
