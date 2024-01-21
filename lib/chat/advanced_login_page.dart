import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'chatscreen.dart';

class AdvancedLoginPage extends StatefulWidget {
  const AdvancedLoginPage({super.key});

  @override
  State<AdvancedLoginPage> createState() => _AdvancedLoginPageState();
}

class _AdvancedLoginPageState extends State<AdvancedLoginPage> {
  final _auth  = FirebaseAuth.instance;

  late bool isLoginPressed;

  final _formKey = GlobalKey<FormState>();

  String userNameValidation = '';
  String userPasswordValidation = '';
  String userPassword2Validation = '';

  bool showSpinner = false;

  void _tryValidation() {
    final hasValidationError = _formKey.currentState?.validate(); // validation 할 것이 없으면 null return하게
    // validation 할 내용 있으면
    if(hasValidationError != null) {
      _formKey.currentState?.save();
    }
  }

  @override
  void initState() {
    isLoginPressed = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Advanced Login'),
            backgroundColor: Colors.amberAccent,
          ),
          body: Stack(
              children: [
                AnimatedPositioned(
                  top : 100,
                  duration: const Duration(milliseconds: 500),
                  curve : Curves.easeIn,
                  child: AnimatedContainer(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    height: isLoginPressed? 320 : 360,
                    width: MediaQuery.of(context).size.width-40,
                    decoration: BoxDecoration(
                      color: Colors.indigo.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(15.0)
                    ),
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                    child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLoginPressed = true;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Text("Login",
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: isLoginPressed ? Colors.amber : Colors.indigo,
                                          ),
                                        ),
                                        if(isLoginPressed)
                                          Container(
                                            height: 10.0,
                                            width: 100.0,
                                            color: Colors.amber,
                                          )
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLoginPressed = false;
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        Text("Sign on",
                                          style: TextStyle(
                                            fontSize: 30,
                                            color: isLoginPressed ? Colors.indigo : Colors.amber,
                                          ),
                                        ),
                                        if(!isLoginPressed)
                                        Container(
                                          height: 10.0,
                                          width: 100.0,
                                          color: Colors.amber,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              if(isLoginPressed)
                              Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        key: const ValueKey(1),
                                        onSaved: (value) {
                                          userNameValidation = value!;
                                        },
                                        onChanged: (value) {
                                          userNameValidation = value!;
                                        },
                                        validator: (value) {
                                          if(value!.isEmpty || value!.length<4){
                                            return 'empty or too short';
                                          }
                                          return null;
                                        },
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.account_circle_outlined,
                                            color: Colors.black,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Colors.black,
                                            ),
                                            borderRadius: BorderRadius.all(Radius.circular(10.0))
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                                          ),
                                          hintText: 'user name',
                                          contentPadding: EdgeInsets.all(15.0),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        key: const ValueKey(2),
                                        onSaved: (value) {
                                          userPasswordValidation = value!;
                                        },
                                        onChanged: (value) {
                                          userPasswordValidation = value!;
                                        },
                                        validator: (value) {
                                          if(value!.isEmpty || value!.length<4){
                                            return 'password too short';
                                          }
                                          return null;
                                        },
                                        obscureText: true,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.password_outlined,
                                            color: Colors.black,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              ),
                                              borderRadius: BorderRadius.all(Radius.circular(10.0))
                                          ),
                                          hintText: 'password',
                                          contentPadding: EdgeInsets.all(15.0),
                                        ),
                                      ),
                                    ],
                                  ),
      
                                ),
                              ),
                              if(!isLoginPressed)
                              Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          onSaved: (value) {
                                            userNameValidation = value!;
                                          },
                                          onChanged: (value) {
                                            userNameValidation = value!;
                                          },
                                          validator: (value) {
                                            if(value!.isEmpty || value!.length<4){
                                              return 'empty or too short';
                                            }
                                            return null;
                                          },
                                          key: const ValueKey(3),
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.account_circle_outlined,
                                              color: Colors.black,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                            ),
                                            hintText: 'user name',
                                            contentPadding: EdgeInsets.all(15.0),
                                          ),
                                        ),
                                        //username
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          key: const ValueKey(4),
                                          onSaved: (value) {
                                            userPasswordValidation = value!;
                                          },
                                          onChanged: (value) {
                                            userPasswordValidation = value!;
                                          },
                                          validator: (value) {
                                            if(value!.isEmpty || value!.length<4){
                                              return 'pasword too short';
                                            }
                                            return null;
                                          },
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.password_outlined,
                                              color: Colors.black,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                            ),
                                            hintText: 'password',
                                            contentPadding: EdgeInsets.all(15.0),
                                          ),
                                        ),
                                        //password1
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          key: const ValueKey(5),
                                          onSaved: (value) {
                                            userPassword2Validation = value!;
                                          },
                                          onChanged: (value) {
                                            userPassword2Validation = value!;
                                          },
                                          validator: (value) {
                                            if(value!.isEmpty || value!.length<4){
                                              return 'pasword2 too short';
                                            }
                                            return null;
                                          },
                                          obscureText: true,
                                          decoration: const InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.password_outlined,
                                              color: Colors.black,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                                borderRadius: BorderRadius.all(Radius.circular(10.0))
                                            ),
                                            hintText: 'password',
                                            contentPadding: EdgeInsets.all(15.0),
                                          ),
                                        ),
                                        //password2
                                      ],
                                    ),
      
                                  ),
                                )
                            ],
                          ),
                      ),
                  ),
                ),
                AnimatedPositioned(
                  top: isLoginPressed ? 360 : 410,
                  right: 0,
                  left:0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 80,
                      height: 80,
                      //color: Colors.amber,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          _tryValidation();
                          setState(() {
                            showSpinner = true;
                          });
                          if(isLoginPressed){
                            try {
                              final newUser = await _auth.signInWithEmailAndPassword(
                                  email: userNameValidation,
                                  password: userPasswordValidation
                              );
                              if(newUser != null){
                                if (!mounted) return;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (buiildContext) => const ChatScreenPage())
                                );
                              }else {
                              }
                            } on Exception catch (e) {
                              print(e);
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("fail to login  check Id and password")
                                ),
                              );
                            }
                          } else {
                            try {
                              final newUser = await _auth.createUserWithEmailAndPassword(
                                  email: userNameValidation,
                                  password: userPasswordValidation
                              );
                              if(newUser != null){
                                if (!mounted) return;
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (buiildContext) => const ChatScreenPage())
                                );
                              }else {
                              }
                            } on Exception catch (e) {
                              print(e);
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("fail to sign in")
                                ),
                              );
                            }
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color : Colors.black.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 1,
                                offset: const Offset(0,2),
                              )
                            ]
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                            size: 40.0,
                          )
                        ),
                      ),
                    ),
                  )
                ),
                //button
                Positioned(
                  top: MediaQuery.of(context).size.height -225,
                  left: 0,
                  right: 0,
                  child: Column(
                    children : [
                      const Text('or google login',
                        style: TextStyle(
                          fontSize: 20.0
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      ElevatedButton(
                        onPressed: (){},
                        child : Container(
                          width: 150,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children : [
                              Icon(Icons.login_sharp),
                              Text(
                                'Google login',
                              )
                            ]
                          ),
                        ),
                      )
                    ]
                  )
                )
              ],
            ),
        ),
      ),
    );
  }
}
