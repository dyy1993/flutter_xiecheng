import 'package:flutter/material.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  List _data = [
    "上海",
    "上海",
    "上海",
    "上海fewfffffffffffffffffffffffff",
    "上海",
    "上海",
    "上海",
    "上海",
    "上海ffffffffw上海ffffffffw上海ffffffffw上海ffffffffw上海ffffffffw上海ffffffffw上海ffffffffw上海ffffffffw上海ffffffffw上海ffffffffw",
    "上海",
    "上海",
    "上海",
    "上海",
    "上海",
    "上海",
    "上海"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('列表'),
        ),
        body: Container(
          child: GridView.count(
            crossAxisCount: 3,
            children: _getItems(),
          ),
        ));
  }

  List<Widget> _getItems() {
    return _data.map((item) => _getWidget(item)).toList();
  }

  Widget _getWidget(item) {
    return Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.blue),
        child: Center(
          child: Text(item),
        ));
  }
}