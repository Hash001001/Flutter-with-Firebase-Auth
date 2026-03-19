import 'package:flutter/material.dart';
import 'package:flutter_auth_tut/screens/profile/profile.dart';
import 'package:flutter_auth_tut/screens/welcome/signin.dart';
import 'package:flutter_auth_tut/services/auth_service.dart';

import '../../shared/styled_button.dart';
import '../../shared/styled_text.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();
  String? _errorMessage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //into text
            const Center(
                child:
                    StyledBodyText("Signup for a new account to get started.")),

            const SizedBox(
              height: 16,
            ),

            //email field
            TextFormField(
              controller: emailControler,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text("Email"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email is required";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),

            //password field
            TextFormField(
              controller: passwordControler,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text("Password"),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Password is required";
                }

                if (value.length < 8) {
                  return "Password must be at least 8 characters";
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),

            //feedback text
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: StyledErrorText(_errorMessage!),
              ),

            //submit button
            StyledButton(
              onPressed: _isLoading
                  ? () {}
                  : () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                          _errorMessage = null;
                        });

                        try {
                          final email = emailControler.text.trim();
                          final password = passwordControler.text.trim();

                          final user =
                              await AuthService.signUp(email, password);

                          if (user != null) {
                            print("User value ->  ${user.email}");
                            // Navigate to next screen or show success

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfileScreen();
                            }));
                          } else {
                            setState(() {
                              _errorMessage =
                                  "Sign up failed. Please try again.";
                            });
                          }
                        } catch (e) {
                          setState(() {
                            _errorMessage = e.toString();
                          });
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : const StyledButtonText("Sign Up "),
            )
          ],
        ),
      ),
    );
  }
}
