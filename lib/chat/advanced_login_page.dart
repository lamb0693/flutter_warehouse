import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_hello/chat/add_image_dlg.dart';
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

  File? userPickedImage;

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

  void pickedImage(File file) {
    userPickedImage = file;
  }

  void showImageDialog(BuildContext context){
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.grey[200],
          child: AddImage(pickedImage),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          return const ChatScreenPage();
        } else {
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
                    // login form
                    AnimatedPositioned(
                      top : 100,
                      duration: const Duration(milliseconds: 500),
                      curve : Curves.easeIn,
                      child: AnimatedContainer(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        height: isLoginPressed? 380 : 400,
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            IconButton(
                                              onPressed: () {showImageDialog(context);} ,
                                              icon: const Icon(Icons.image_outlined,
                                                size: 40,
                                              )),
                                          ],
                                        ),
                                      ],
                                    ),

                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // login sign in button
                    AnimatedPositioned(
                        top: isLoginPressed ? 400 : 440,
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
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }else {
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("fail to login  user = null")
                                        ),
                                      );
                                      setState(() {
                                        showSpinner = false;
                                      });
                                    }
                                  } on Exception catch (e) {
                                    if (!mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("fail to login  check Id and password")
                                      ),
                                    );
                                  }
                                } else {  // is sign on
                                  if(userPickedImage == null){
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text("pick your image file")
                                      ),
                                    );
                                  } else {
                                    try {
                                      final newUser = await _auth.createUserWithEmailAndPassword(
                                          email: userNameValidation,
                                          password: userPasswordValidation
                                      );
                                      if(newUser != null){
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        final refImage = FirebaseStorage.instance.ref().child('user_image').child('bbb.png');
                                        await refImage.putFile(userPickedImage!);
                                      }else {
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        if (!mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                              content: Text("faile to sign in newUse == null")
                                          ),
                                        );
                                      }
                                    } on Exception catch (e) {
                                      if (!mounted) return;
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text("fail to sign in, ${e.toString()}")
                                        ),
                                      );
                                    }
                                  }
                                }
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
      },
    );
  }
}
