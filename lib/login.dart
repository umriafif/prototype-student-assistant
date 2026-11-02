import 'package:flutter/material.dart';

void main(){
  runApp(const Login());
}

class Login extends StatelessWidget{
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget{
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Icon(
                Icons.arrow_back_sharp
                )
              )
          ],
        )
      ),
    );
  }
}