import 'package:flutter/material.dart';
import 'package:flutter_hello/test/json_service.dart';
import 'package:flutter_hello/test/user_json.dart';

class JsonParsingPage extends StatefulWidget {
  const JsonParsingPage({super.key});

  @override
  State<JsonParsingPage> createState() => _JsonParsingPageState();
}

class _JsonParsingPageState extends State<JsonParsingPage> {
  List<JsonUser> _users = [];
  bool loaded = false;

  @override
  void initState() {
    // TODO: implement initState
    JsonService().getUserInfo().then( (value) {
      setState(() {
        _users = value;
        loaded = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Json Parsing"),
        backgroundColor: Colors.purple,
      ),
      body : Container(
        padding: const EdgeInsets.all(19.0),
        child : ListView.builder(
          itemCount: _users.length,
          itemBuilder: (BuildContext context, int index) {
            if(loaded == true){
              return ListTile(
                leading: const Icon(Icons.supervised_user_circle_rounded),
                title: Text(_users[index].name),
                subtitle: Text(_users[index].email),
                trailing: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(_users[index].name),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_users[index].company.name,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(_users[index].company.catchPhrase,
                                style: const TextStyle(
                                  fontSize: 10.0,
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: const Text('close'))
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )
      )
    );
  }
}
