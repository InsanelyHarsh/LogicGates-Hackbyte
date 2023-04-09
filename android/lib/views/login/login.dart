

import 'package:android/api/auth.dart';
import 'package:android/models/local_db.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Auth auth = Auth();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final ans = await auth.loginUser({
        'email': _emailController.text,
        'password': _passwordController.text
      });
      // ignore: use_build_context_synchronously
      final localDb = Provider.of<LocalDb>(context,listen: false);
      debugPrint('return');
      //print(ans);
      if (ans['success'] == true) {
        await localDb.saveUserDetailsToLocalDb(ans);
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        // ignore: use_build_context_synchronously
        await ArtSweetAlert.show(
          barrierDismissible: false,
          context: context,
          artDialogArgs: ArtDialogArgs(
            title: 'Login Failed',
            text: 'Return back',
            confirmButtonText: 'Ok',
            type: ArtSweetAlertType.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome to Spotlight',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.length < 14 ||
                            !value.contains('@gmail.com')) {
                          return 'Please enter correct email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Please enter your password or longer password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: () => _login(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/signup', (route) => false);
                      },
                      child: const Text('Dont have a account? Create one',
                          style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
