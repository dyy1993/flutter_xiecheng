import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/travel_dao.dart';
import 'package:flutter_demo/model/travel_tab_model.dart';

class TravelPage extends StatefulWidget {
  @override
  _TravelPageState createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<TravelTab> tabs = [];

  @override
  void initState() {
    _tabController = TabController(length: 0, vsync: this);
    TravelDao.fetchTab().then((TravelTabModel tabModel) {
      _tabController = TabController(length: tabModel.tabs.length, vsync: this);
      setState(() {
        tabs = tabModel.tabs;
      });
    }).catchError((e) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 30),
            child: TabBar(
                controller: _tabController,
                tabs: tabs.map(
                  (TravelTab tab) {
                    return Tab(text: tab.labelName);
                  },
                ).toList(),
                isScrollable: true,
                labelColor: Colors.black,
                labelPadding: EdgeInsets.fromLTRB(20, 0, 10, 5),
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      color: Color(0xff2fcfbb),
                      width: 3,
                    ),
                    insets: EdgeInsets.only(bottom: 10)))),
        Flexible(
            child: Container(
          child: TabBarView(
            controller: _tabController,
            children: tabs.map((TravelTab tab) {
              return Text(tab.labelName);
            }).toList(),
          ),
        ))
      ],
    ));
  }
}
