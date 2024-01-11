
import 'package:flutter/material.dart';

class FutureBuildTestPage extends StatefulWidget {
  const FutureBuildTestPage({super.key});

  @override
  State<FutureBuildTestPage> createState() => _FutureBuildTestPageState();
}

class _FutureBuildTestPageState extends State<FutureBuildTestPage> {
  late int result;
  TextEditingController numberController = TextEditingController();

  Future<int?> calculate() async{
    await Future.delayed(const Duration(seconds: 3));
    print("3 seconds delayed");
    return 2 * int.parse(numberController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future Builder Test'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              const Text('2X',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
              SizedBox(
                width: 50.0,
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      gapPadding: 0,
                    )
                  ),
                  controller: numberController,
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              const Text('=',
                style: TextStyle(
                  fontSize: 40,
                ),
              ),
            ]
          ),
          ElevatedButton(
            child: const Text('계산'),
            onPressed: () async {
              int? resultData = await calculate();
              if(resultData == null) return;
              setState(() {
                result = resultData;
              });
            },
          ),
          const Divider(
            thickness: 3,
            height: 20,
          ),
          FutureBuilder(
              future: calculate(),
              builder: (context, snapshot) {
                if(snapshot.connectionState==ConnectionState.done) {
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(
                      fontSize: 40,
                    ),
                );
                }
                return const CircularProgressIndicator();
              }
          ),
        ],
      ),
    );
  }
}
