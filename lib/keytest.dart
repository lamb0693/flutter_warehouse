import 'package:flutter/material.dart';

class KeyTestPage extends StatefulWidget {
  KeyTestPage({super.key});

  int test=1;

  @override
  State<KeyTestPage> createState() => _KeyTestPageState();
}

class _KeyTestPageState extends State<KeyTestPage> {
  final counterKey = GlobalKey<_CounterState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Key Test'),
        backgroundColor: Colors.amberAccent,
      ),
      body : Center(
        child: Container(
          width: 200.0,
          color: Colors.grey,
          height: 130.0,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Counter(
                key: counterKey,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  counterKey.currentState?.increment();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(100.0, 50.0),
                ),
                child: const Center(
                    child: Text('increase')
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});
  //const Counter({Key? key}) : super(key : key);

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;

  void increment(){
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text('$count',
          style: const TextStyle(
            fontSize: 30,
          ),
        )
    );
  }
}

