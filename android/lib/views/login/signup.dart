import 'package:android/api/auth.dart';
import 'package:android/models/local_db.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _userTypeController = TextEditingController();
  Auth auth = Auth();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signup() async {
    if (_formKey.currentState!.validate()) {
      final ans = await auth.createUser({
        'email': _emailController.text,
        'password': _passwordController.text,
        'name': _nameController.text,
        'username': _usernameController.text,
        'userType': _userTypeController.text,
      });
      // ignore: use_build_context_synchronously
      final localDb = Provider.of<LocalDb>(context, listen: false);
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
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 20,),
                    const Text(
                      'Signup',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 16.0),
                    textFormField(_nameController, false, 'Name', (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Please enter your Name';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16.0),
                    textFormField(_usernameController, false, 'Username',
                        (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Username too short';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16.0),
                    textFormField(_emailController, false, 'Email', (value) {
                      if (value!.isEmpty ||
                          value.length < 14 ||
                          !value.contains('@gmail.com')) {
                        return 'Please enter your email';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16.0),
                    textFormField(_userTypeController, false, 'User Type',
                        (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your usertype';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16.0),
                    textFormField(_passwordController, true, 'Password',
                        (value) {
                      if (value!.isEmpty ||
                          value.length < 6 ||
                          value != _confirmPasswordController.text) {
                        return 'Please enter your password';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16.0),
                    textFormField(
                        _confirmPasswordController, true, 'Confirm Password',
                        (value) {
                      if (value!.isEmpty) {
                        return 'Password dosent match';
                      }
                      return null;
                    }),
                    const SizedBox(height: 16.0),
                    GestureDetector(
                      onTap: signup,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'Signup',
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
                            context, '/login', (route) => false);
                      },
                      child: const Text(
                          'Already have an account? Login Instead',
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

  textFormField(TextEditingController cont, bool showText, String text,
      String? Function(String?) f) {
    return TextFormField(
      controller: cont,
      obscureText: showText,
      decoration: InputDecoration(
        labelText: text,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
      ),
      validator: f,
    );
  }
}
