import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.grey,
      ),
      body: Form(
        child: Theme(
          data : ThemeData(
            primaryColor: Colors.deepPurpleAccent,
            inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15.0,
              )
            )
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Enter id',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: idController,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'password',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      controller: pwdController,
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    ButtonTheme(
                      minWidth: 100.0,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: (){
                          String id = idController.text;
                          String pwd = pwdController.text;
                          if(id=='ldw' && pwd=='0000'){
                            Fluttertoast.showToast(
                              msg: '로그인 성공',
                              fontSize: 30.0,
                              backgroundColor: Colors.cyanAccent,
                              gravity: ToastGravity.CENTER,
                              toastLength: Toast.LENGTH_SHORT,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                content: Text('id나 비밀번호가 틀려요'))
                            );
                          }
                        },
                        child : const Icon(
                          Icons.arrow_forward,
                          color: Colors.green,
                          size: 45.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
