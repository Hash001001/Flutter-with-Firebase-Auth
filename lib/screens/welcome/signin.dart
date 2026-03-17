import 'package:flutter/material.dart';

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
              validator: (value){
                if(value == null || value.isEmpty){
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
              validator: (value){
                if(value == null || value.isEmpty){
                  return "Password is required";
                }
                return null;
              },
            ),

            const SizedBox(
              height: 16,
            ),

            //feedback text

            //submit button
            StyledButton(
              onPressed: () async {
                if(_formKey.currentState!.validate()){
                  var email = emailControler.text.trim();
                  var password = passwordControler.text.trim();
                }
              },
              child: const StyledButtonText("Sign In"),
            )
          ],
        ),
      ),
    );
  }
}
