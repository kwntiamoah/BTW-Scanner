import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanner_app/config/colors.dart';
import 'package:scanner_app/screens/scanner.dart';

class Success extends StatelessWidget {
  final String userId;
  final dynamic details;

  const Success({Key? key, required this.userId, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(details);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset('assets/lottie/success.json', height: 250),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(5),
              //   border: Border.all(width: .5, color: Colors.grey)
              // ),
              child: ListTile(
                title: Text(details['plan_name']),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${details['ticket']} Ticket',
                      style: const TextStyle(
                          fontSize: 12.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                    Text(
                      'Recipient: ${details['recipient_number']}',
                      style: const TextStyle(fontSize: 12.5),
                    ),
                    Text(
                      details['trans_ref_code'],
                      style: const TextStyle(fontSize: 12.5),
                    ),
                  ],
                ),
                leading: Icon(Icons.paste, color: Colors.green),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * .08),
            Text('Issued By: ${details['verified_by']}'),
            const SizedBox(height: 14),
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
