import 'package:flutter_demo/model/travel_model.dart';
import 'package:flutter_demo/model/travel_tab_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const tabUrl = 'http://www.devio.org/io/flutter_app/json/travel_page.json';

class TravelDao {
  //获取单个通道数据
  static Future<TravelModel> fetchTravel(String url, Map params,
      String groupChannelCode, int index, int pageSize) async {
    Map paramsMap = params['pagePara'];
    paramsMap['pageIndex'] = index;
    paramsMap['pageSize'] = pageSize;
    params['groupChannelCode'] = groupChannelCode;
    final res = await http.post(url, body: jsonEncode(params));
    if (res.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var data = json.decode(utf8decoder.convert(res.bodyBytes));
      return TravelModel.fromJson(data);
    } else {
      throw Exception('Failed request');
    }
  }

  //获取tab数据
  static Future<TravelTabModel> fetchTab() async {
    final res = await http.get(tabUrl);
    if (res.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      var data = json.decode(utf8decoder.convert(res.bodyBytes));
      return TravelTabModel.fromJson(data);
    } else {
      throw Exception('Failed request');
    }
  }
}
