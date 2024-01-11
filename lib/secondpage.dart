import "package:flutter/material.dart";

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SecondPageState();
  }

}

class SecondPageState extends State<SecondPage> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('이수찬 세부 정보'),
          backgroundColor: Colors.amber,
        ),
        body: Container(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () { 
                      Navigator.pop(context);
                    },
                    child: const Text('수찬이 명함으로 돌아가기',
                        style: TextStyle(
                          fontSize: 25,
                        )
                    )
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        count ++;
                      });
                    },
                    child: const Text('숫자 증가',
                        style: TextStyle(
                          fontSize: 25,
                        )
                    )
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text('$count',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            )
          ),
    );
  }
}