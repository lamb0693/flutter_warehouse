import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hello/firebase/login.dart';
import 'package:flutter_hello/test/login.dart';
import 'package:flutter_hello/test/stream__builder_test.dart';
import 'package:flutter_hello/test/time_builder.dart';

import 'chat/advanced_login_page.dart';
import 'display.dart';
import 'package:flutter_hello/test/futurebuilder.dart';
import 'geolocator.dart';
import 'test/keytest.dart';

import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main () async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello App",
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage() ,
    );
  }
}

Builder myBuilder(IconData icon, String strText, void Function(BuildContext buildContext) callback) {
  return Builder(builder: (BuildContext buildContext) {
    return ListTile(
      leading: Icon(icon, color: Colors.redAccent),
      title: Text(strText),
      onTap: () {
        ScaffoldMessenger.of(buildContext).showSnackBar(SnackBar(
            content: Text(strText)));
        Navigator.of(buildContext).pop();
        callback(buildContext);
      },
      trailing: const Icon(Icons.add),
    );
  });
}

void toLoginFirebase(BuildContext buildContext){
  Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buiildContext) => const LoginFirebase())
  );
}

void toTestFutureBuild(BuildContext buildContext){
  Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buiildContext) => const FutureBuildTestPage())
  );
}

void toGeolocator(BuildContext buildContext){
  Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buiildContext) => const GeolocatorPage())
  );
}

void toTimebuilder(BuildContext buildContext){
  Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buiildContext) => const TimebuilderPage())
  );
}

void toAdvancedLoginPage(BuildContext buildContext){
  Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buiildContext) => const AdvancedLoginPage())
  );
}

void toStreambuilder(BuildContext buildContext){
  Navigator.of(buildContext).push(MaterialPageRoute(
      builder: (buiildContext) => const StreamBuilderPage())
  );
}

class MySnackBar extends StatelessWidget {
  const MySnackBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.home, color: Colors.redAccent),
      title: const Text('Home'),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Home'))
        );
        Navigator.of(context).pop();
      },
      trailing: const Icon(Icons.add),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        key: super.key,
        title: const Text("Hello App"),
        backgroundColor: Colors.lightGreen[200],
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_basket_outlined),
            onPressed: () {  },
          ),// Set the backgroun
          IconButton(
            icon: const Icon(Icons.logout_outlined),
            onPressed: () {  },
          ),// Set the backgroun
        ],
      ),
      body: DisplayInfo(context),
      drawer: Drawer(
        child : ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const CircleAvatar(
                foregroundImage: AssetImage('assets/lsc.jpg'),
                radius: 20,
              ),
              otherAccountsPictures: const [
                CircleAvatar(
                  foregroundImage: AssetImage('assets/lsc.jpg'),
                  radius: 10,
                ),
              ],
              accountName: const Text('이수찬'),
              accountEmail: const Text('chance10312@naer.com'),
              onDetailsPressed: () {
                if (kDebugMode) {
                  print("detail pressed");
                }
              },
              decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight:Radius.circular(20.0),
                  )
              ),
            ),
            Builder(builder: (BuildContext buildContext) {
              return ListTile(
                leading: const Icon(Icons.home, color: Colors.redAccent),
                title: const Text('Key test'),
                onTap: () {
                  Navigator.of(buildContext).pop();
                  Navigator.of(buildContext).push(
                      MaterialPageRoute(builder: (buildContext) {
                        return KeyTestPage();
                      }));
                },
                trailing: const Icon(Icons.add),
              );
            }),
            Builder(builder: (BuildContext buildContext) {
              return ListTile(
                leading: const Icon(Icons.login, color: Colors.redAccent),
                title: const Text('Login'),
                onTap: () {
                  Navigator.of(buildContext).pop();
                  Navigator.of(buildContext).push(
                    MaterialPageRoute(builder: (buildContext) {
                      return const LoginPage();
                    }));
                },
                trailing: const Icon(Icons.add),
              );
            }),
            myBuilder(Icons.gps_fixed, 'Geolocator', toGeolocator),
            myBuilder(Icons.watch_later, 'TimeBuilder', toTimebuilder),
            myBuilder(Icons.view_stream, 'StreamBuilder', toStreambuilder),
            myBuilder(Icons.build , 'FutureBuild Test', toTestFutureBuild),
            myBuilder(Icons.search, 'Firebase', toLoginFirebase),
            myBuilder(Icons.login_sharp, 'Login, Advanced', toAdvancedLoginPage),
            const MySnackBar(),
          ],
        )
      ),
    );
  }
}



