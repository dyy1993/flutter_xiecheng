/*
 * @Author: yangyang.ding 
 * @Date: 2019-04-19 22:28:29 
 * @Last Modified by:   yangyang.ding 
 * @Last Modified time: 2019-04-19 22:28:29 
 */

import 'package:flutter_demo/model/search_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class SearchDao {
  //搜索接口
  static Future<SearchModel> fetch(String url, String keyWord) async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var result = json.decode(utf8decoder.convert(response.bodyBytes));
      SearchModel model = SearchModel.fromJson(result);
      model.keyWord = keyWord;
      return model;
    }else {
      throw Exception("Failed to homeData");
    }
  }
}