import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkRequest {

  NetworkRequest(this.url);
  String url;

  Future getData() async{
    http.Response response = await http.get(url);
    if (response.statusCode == 200){
      print(response.body);
      return jsonDecode(response.body);
    }else{
      print(response.statusCode);
    }
  }
}
