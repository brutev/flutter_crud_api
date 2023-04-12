import 'package:flutter/material.dart';
import 'package:flutter_crud_api/const/constant.dart';
import 'package:flutter_crud_api/views/screens/dashboard.dart';
import 'package:flutter_crud_api/views/widgets/login_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Image.asset('assets/images/flutter_logo.png', scale: 4.0),
              Container(
                padding: const EdgeInsets.all(10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(fontSize: 30),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                            labelText: 'Email'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return kEmptyEmailAddress;
                          } else if (!RegExp(kEMailRegexPattern)
                              .hasMatch(value)) {
                            return kValidEmailAddress;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: passwordController,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _isObscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    size: 18,
                                    color: const Color(0xFF909CAA)),
                                onPressed: () {
                                  setState(() {
                                    _isObscure = !_isObscure;
                                  });
                                }),
                            border: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: Colors.grey)),
                            labelText: 'Password'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return kEnterPassword;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      LoginButton(
                          label: "Login",
                          onPressed: () {
                            if (_formKey.currentState != null &&
                                _formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const DashBoard()));
                            }
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
