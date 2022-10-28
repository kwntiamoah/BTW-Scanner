import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:scanner_app/config/colors.dart';
import 'package:scanner_app/repo/qrRepo.dart';
import 'package:scanner_app/screens/error.dart';
import 'package:scanner_app/screens/notFound.dart';
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
  TextEditingController qrTextController = TextEditingController();

  final MobileScannerController _mobileScannerController =
      MobileScannerController(facing: CameraFacing.back, torchEnabled: false);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobileScannerController.dispose();
  }

  void scanQR(String qr_text, String src) async {
    setState(() {
      _isLoading = true;
    });
    dynamic qrParams = {
      "qr_text": src == 'S' ? qr_text.replaceAll("Reference:", "").trim() : qr_text.trim(),
      "user_id": widget.userId,
      "scan_type": src
    };
    print(qrParams);

    try {
      dynamic res = await _qrRepo.scan_qr(qrParams);

      if (res["resp_code"].toString() == "00") {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return Success(userId: widget.userId, details: res['details']);
        }));
      } else {

        if (res["resp_code"].toString() == "027") {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
            return NotFound(
              userId: widget.userId,
              description: res["resp_desc"],
            );
          }));
        }

        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
          return Error(
            userId: widget.userId,
            response: res,
          );
        }));
      }

    } catch (e) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
              Error(userId: widget.userId, response: null)));
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
                    scanQR(code, 'S');
                  }
                }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: KColors.primaryColor,
          onPressed: () => _showBottomSheet(),
          child: Icon(Icons.text_fields),
        ));
  }

  Widget _qrTextField() {
    return TextFormField(
      controller: qrTextController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      validator: (val) => val!.isEmpty ? "6 digit code is required" : null,
      decoration: const InputDecoration(labelText: '123456'),
    );
  }

  Widget _scanBtn() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: TextButton.icon(
          onPressed: () {
            scanQR(qrTextController.text, 'T');
            Navigator.pop(context);
            qrTextController.clear();
          },
          icon: const Icon(Icons.qr_code_scanner_rounded),
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: KColors.primaryColor),
          label: Text('Continue')),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
        useRootNavigator: true,
        context: context,
        builder: (BuildContext context) {
          return ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            child: Container(
              height: 500,
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter 6-digit code"),
                    SizedBox(height: 5),
                    _qrTextField(),
                    SizedBox(height: 10),
                    _scanBtn()
                  ],
                ),
              ),
            ),
          );
        });
  }
}
