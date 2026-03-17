import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsGeometry.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.stretch,
          children: [
            //into text
            const StyledBodyText("Signup for a new account to get started."),

        const SizedBox(height: 16,),

            //email field
            TextFormField(
              controller: emailControler,
              keyboardType:  TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text("Email"),
                
              ),
            ),
        const SizedBox(height: 16,),
            
            //password field
            TextFormField(
              controller: passwordControler,
              obscureText: true,
              decoration: const InputDecoration(
                label: Text("Password"),
              ),

            ),
            const SizedBox(height: 16,),
            
            //feedback text

            //submit button
            StyledButton(
              onPressed: () async{
                
              },
              child: const StyledButtonText("Sign Up "),
            )
          ],
        ),
      ),
    );
  }
}
