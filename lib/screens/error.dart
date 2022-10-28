import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanner_app/config/colors.dart';
import 'package:scanner_app/generated/assets.dart';
import 'package:scanner_app/screens/scanner.dart';

class Error extends StatelessWidget {
  final dynamic response;
  final String userId;

  const Error({Key? key, required this.userId, required this.response})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(Assets.lottieError, height: 250),
            response == null
                ? SizedBox.shrink()
                : SizedBox(
                    height: MediaQuery.of(context).size.height * .05,
                    child: Text(response['resp_desc']),
                  ),
            response == null
                ? const Text('Sorry an error occured')
                : Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(5),
                    //   border: Border.all(width: .5, color: Colors.grey)
                    // ),
                    child: ListTile(
                      title: Text(response['details']['plan_name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Recipient: ${response['details']['recipient_number']}',
                            style: const TextStyle(fontSize: 12.5),
                          ),
                          Text(
                            response['details']['trans_ref_code'],
                            style: const TextStyle(fontSize: 12.5),
                          ),
                        ],
                      ),
                      leading:
                          const Icon(Icons.warning_rounded, color: Colors.red),
                    ),
                  ),
            SizedBox(height: MediaQuery.of(context).size.height * .08),
            response == null
                ? const SizedBox.shrink()
                : Text('Issued By: ${response['details']['verified_by']}'),
            response == null
                ? const SizedBox.shrink()
                : const SizedBox(height: 14),
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
