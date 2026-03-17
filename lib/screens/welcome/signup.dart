import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsetsGeometry.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment:  CrossAxisAlignment.stretch,
          children: [
            //into text
            Center(
                child: const StyledBodyText("Signup for a new account to get started.")),

        const SizedBox(height: 16,),

            //email field
            TextFormField(
              controller: emailControler,
              keyboardType:  TextInputType.emailAddress,
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
        const SizedBox(height: 16,),
            
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

                if(value.length < 8){
                  return "Password must be at least 8 characters";
                }
                return null;
              },
            ),
            const SizedBox(height: 16,),
            
            //feedback text

            //submit button
            StyledButton(
              onPressed: () async{
                if(_formKey.currentState!.validate()){
                  var email = emailControler.text.trim();
                  var password = passwordControler.text.trim();

                  final user = await AuthService.signUp(email, password);

                  print("User value ->  ${user!.email}");

                }
              },
              child: const StyledButtonText("Sign Up "),
            )
          ],
        ),
      ),
    );
  }
}
