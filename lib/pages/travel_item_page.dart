import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/travel_dao.dart';
import 'package:flutter_demo/model/travel_model.dart';

const PAGESIZE = 10;
const _TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelItemPage extends StatefulWidget {
  final String url;
  final String channel;
  final Map params;

  const TravelItemPage({Key key, this.url, this.channel, this.params}) : super(key: key);
  @override
  _TravelItemPageState createState() => _TravelItemPageState();
}

class _TravelItemPageState extends State<TravelItemPage>{
  List<TravelItem> travelItems = [];
  int index = 1;
  @override
  void initState() {
    TravelDao.fetchTravel(widget.url, widget.params, widget.channel, index, PAGESIZE).then((TravelModel model){
      
      setState(() {
        travelItems = model.resultList;
      });

    }).catchError((e){
      print(e);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container());
  }
}
