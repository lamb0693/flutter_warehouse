import 'package:flutter/material.dart';
import 'package:flutter_hello/firebase/loginbutton.dart';

void goolgeLogin(){

}

void emailLogin(){

}

class LoginFirebase extends StatelessWidget {
  const LoginFirebase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Login'),
        backgroundColor: Colors.indigoAccent,
      ),
      body : Container(
        padding: const EdgeInsets.all(30.0),
        
        child: const Column(
          children: [
            LoginButton(
              strText: 'Google login',
              iconData: Icons.login,
              callback: goolgeLogin,
            ),
            SizedBox(
              height: 20.0,
            ),
            LoginButton(
              strText: 'Email login',
              iconData: Icons.email,
              callback: emailLogin,
            ),
          ],
        ),
      )
    );
  }
}
