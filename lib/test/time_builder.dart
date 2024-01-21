import 'package:intl/date_symbol_data_local.dart';
import 'package:timer_builder/timer_builder.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class TimebuilderPage extends StatefulWidget {
  const TimebuilderPage({super.key});

  @override
  State<TimebuilderPage> createState() => _TimebuilderPageState();
}

class _TimebuilderPageState extends State<TimebuilderPage> {


  @override
  void initState() {
    initializeDateFormatting();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timebuilder Example'),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 150,
            child: Image.asset('assets/lsc.jpg'),
          ),
          Positioned(
            height: 200,
            top: 0,
            child: Container(
              margin: const EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width -40.0,
              color: Colors.amber,
              child: TimerBuilder.periodic(const Duration(seconds: 1),
                builder: (context) {
                  return Column(
                    children : [
                      Text(DateFormat("yyyy년 MM월 dd일 HH시 mm분 ss초").format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ]
                  );
                },
              ),
            ),
          ),
          Positioned(
            height: 200,
            top: 100,
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              margin: const EdgeInsets.all(40.0),
              width: MediaQuery.of(context).size.width -80.0,
              //color: Colors.indigo.withOpacity(0.5), //decoration이 있으면 이것 못씀
              decoration: BoxDecoration( 
                color: Colors.indigo.withOpacity(0.5), 
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: RichText(
                text: const TextSpan(
                  text: 'Hello',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: ' world',
                      style: TextStyle(
                        letterSpacing: 2.0,
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
