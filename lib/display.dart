import "package:flutter/material.dart";
import "package:flutter_hello/secondpage.dart";

class DisplayInfo extends StatelessWidget {
  final BuildContext context;

  const DisplayInfo(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 60, 0, 0),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(50, 10, 0, 0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/lsc.jpg'),
              radius: 100,
            ),
          ),
          const Divider(
            height: 60,
            thickness: 2,
            endIndent: 50,
            color: Colors.amberAccent,
          ),
          const Text('Name',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
              letterSpacing: 3.0,
            ),
          ),
          const SizedBox(
            height: 2.0,
          ),
          const Text('이수찬',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 50,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text('Age',
            style: TextStyle(
              color: Colors.redAccent,
              fontSize: 20,
              letterSpacing: 3.0,
            ),
          ),
          const SizedBox(
            height: 2.0,
          ),
          const Text('20',
            style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 50,
              letterSpacing: 2.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SafeArea(
            child: Container(
              color: Colors.green[200],
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {return const SecondPage();}
                    )
                  );
                },
                child: const Text("2nd Page"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



