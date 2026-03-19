import 'package:flutter_auth_tut/screens/welcome/signin.dart';
import 'package:flutter_auth_tut/screens/welcome/signup.dart';
import 'package:flutter_auth_tut/shared/styled_text.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool isSignUpScreen = true;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const StyledAppBarText('Flutter Auth'),
        backgroundColor: Colors.blue[500],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StyledHeading('Welcome'),

              // sign up screen
              if(isSignUpScreen)
                Column(
                  children: [
                    SignUpForm(),
                    TextButton(
                      onPressed: (){
                        setState(() {
                          isSignUpScreen = false;
                        });
                      },
                      child: const StyledBodyText("Already have an account? Sign in.")
                    )
                  ],
                ),

              // sign in screen
              if(!isSignUpScreen)
                Column(
                  children: [
                    SignInForm(),
                    TextButton(
                        onPressed: (){
                          setState(() {
                            isSignUpScreen = true;
                          });
                        },
                        child: const StyledBodyText("Don't have an account? Sign up.")
                    )
                  ],
                )

            ]
          )
        ),
      ),
    );
  }
}