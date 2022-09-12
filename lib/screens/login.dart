import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanner_app/config/appConstants.dart';
import 'package:scanner_app/config/colors.dart';
import 'package:scanner_app/repo/authRepo.dart';
import 'package:scanner_app/screens/scanner.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthRepo _authRepo = AuthRepo();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      dynamic authParams = {
        "username": _usernameController.value.text.trim(),
        "password": _passwordController.value.text.trim(),
        "src": "APP"
      };

      try {
        dynamic res = await _authRepo.authLogin(authParams);
        if (res['resp_code'] == '000') {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
                  Scanner(userId: res['user_id'].toString())));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              res['resp_desc'],
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'An error occured logging in',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: _isLoading
              ? _loader()
              : SizedBox(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    child: _loginBody(),
                    physics: const ClampingScrollPhysics(),
                  ))),
    );
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

  Widget _loginBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _qrScanner(),
            Center(
                child: Text('BigTicketWave Scanner',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18, color: KColors.primaryColor))),
            const SizedBox(height: 40),
            const Text(AppConstants.LOGIN_TEXT,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 20),
            _usernameField(),
            const SizedBox(height: 8),
            _passwordField(),
            const SizedBox(height: 8),
            _loginBtn()
          ],
        ),
      ),
    );
  }

  Widget _qrScanner() {
    return Center(
        child: Lottie.asset(
      'assets/lottie/qr_scanner.json',
      width: 200,
      height: 200,
    ));
  }

  Widget _usernameField() {
    return TextFormField(
      controller: _usernameController,
      textInputAction: TextInputAction.next,
      validator: (val) => val!.isEmpty ? "Username is required" : null,
      decoration: const InputDecoration(labelText: 'Username'),
    );
  }

  Widget _passwordField() {
    return TextFormField(
      controller: _passwordController,
      textInputAction: TextInputAction.done,
      obscureText: true,
      validator: (val) => val!.isEmpty ? "Password is required" : null,
      decoration: const InputDecoration(labelText: 'Password'),
    );
  }

  Widget _loginBtn() {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: TextButton.icon(
          onPressed: _login,
          icon: const Icon(Icons.qr_code_scanner_rounded),
          style: TextButton.styleFrom(
              primary: Colors.white,
              backgroundColor: KColors.primaryColor),
          label: Text('Login')),
    );
  }
}
