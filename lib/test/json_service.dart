import 'package:flutter_hello/test/user_json.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class JsonService{
  static const dataUrl = 'https://jsonplaceholder.typicode.com/users';

  Future<List<JsonUser>> getUserInfo() async{
    try{
      final response = await http.get(Uri.parse(dataUrl));
      if(response.statusCode==200){
        List<JsonUser> userList= jsonUserFromJson(response.body);
        return userList;
      } else {
        Fluttertoast.showToast(msg: 'Error to connect');
        return <JsonUser>[];
      }
    } catch(e) {
      Fluttertoast.showToast(msg: e.toString());
      return <JsonUser>[];
    }
  }
}
