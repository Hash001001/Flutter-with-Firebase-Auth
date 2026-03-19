import 'package:flutter/material.dart';
import 'package:flutter_auth_tut/screens/profile/profile.dart';
import 'package:flutter_auth_tut/services/auth_service.dart';

import '../../shared/styled_button.dart';
import '../../shared/styled_text.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final emailControler = TextEditingController();
  final passwordControler = TextEditingController();

  String? _errorMessage;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //into text
            Center(child: const StyledBodyText("Sign in to your account.")),

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
                return null;
              },
            ),

            const SizedBox(
              height: 16,
            ),

            //feedback text

            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: StyledErrorText(_errorMessage.toString()),
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
                          var email = emailControler.text.trim();
                          var password = passwordControler.text.trim();

                          final user =
                              await AuthService.signIn(email, password);

                          if (user != null) {
                            print("Sign in User value ->  ${user.email}");

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfileScreen();
                            }));
                          } else {
                            setState(() {
                              _errorMessage =
                                  "An error occurred while signing in";
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
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                          color: Colors.white, strokeWidth: 2),
                    )
                  : const StyledButtonText("Sign In"),
            )
          ],
        ),
      ),
    );
  }
}
