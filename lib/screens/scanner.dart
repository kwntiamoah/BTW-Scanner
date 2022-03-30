import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_app/config/colors.dart';
import 'package:scanner_app/repo/qrRepo.dart';
import 'package:scanner_app/screens/error.dart';
import 'package:scanner_app/screens/success.dart';

class Scanner extends StatefulWidget {
  final String userId;

  const Scanner({Key? key, required this.userId}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final QRRepo _qrRepo = QRRepo();
  bool _isLoading = false;

  final MobileScannerController _mobileScannerController = MobileScannerController(
  facing: CameraFacing.back, torchEnabled: false);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobileScannerController.dispose();
  }

  void scanQR(String qr_text) async {
    setState(() {
      _isLoading = true;
    });
    dynamic qrParams = {
      "qr_text": qr_text,
      "user_id": widget.userId,
    };

    try {
      dynamic res = await _qrRepo.scan_qr(qrParams);
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) =>
              res['resp_code'] == '00' ? const Success() : Error(message: res['resp_desc'],)));
    } catch (e) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => const Error(message: 'Sorry an error occured')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _loader() {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: Lottie.asset('assets/lottie/loading.json'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('QR Scanner', style: TextStyle(fontSize: 16)),
            backgroundColor: KColors.primaryColor),
        body: _isLoading
            ? _loader()
            : MobileScanner(
                allowDuplicates: false,
                controller: _mobileScannerController,
                onDetect: (barcode, args) {
                  final String? code = barcode.rawValue;
                  if (code != null) {
                    scanQR(code);
                  }
                }));
  }
}
