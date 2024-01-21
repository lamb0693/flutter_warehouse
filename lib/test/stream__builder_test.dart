import 'package:flutter/material.dart';

class StreamBuilderPage extends StatefulWidget {
  const StreamBuilderPage({super.key});

  @override
  State<StreamBuilderPage> createState() => _StreamBuilderPageState();
}

class _StreamBuilderPageState extends State<StreamBuilderPage> {
  final int price = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Builder Test"),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: StreamBuilder<int>(
          initialData: price,
          stream: getIntStream(),
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return Text(snapshot.data.toString(),
              style: const TextStyle(
                fontSize: 40,
              ),
            );
          },
        ),
      ),
    );
  }

  Stream<int> getIntStream() {
    return Stream<int>.periodic(const Duration(milliseconds: 1000),
            (x) => price + x
    );
  }
}
