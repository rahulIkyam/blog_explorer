import 'dart:convert';

import '../model/item_model.dart';
import 'package:http/http.dart' as http;

//  Second

class ItemNetwork{
  Future<ItemModel> fetchItemData() async{
    String url = "https://intent-kit-16.hasura.app/api/rest/blogs";
    final response = await http.get(
        Uri.parse(url),
        headers: {
          "x-hasura-admin-secret":"32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6"
        }
    );
    if(response.statusCode == 200){
      return ItemModel.fromProvider(json.decode(response.body));
    }else{
      throw(response.statusCode.toString()+response.body);
    }
  }
}