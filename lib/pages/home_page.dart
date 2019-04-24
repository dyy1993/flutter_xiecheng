import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/home_dao.dart';
import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/model/config_model.dart';
import 'package:flutter_demo/model/grid_nav_model.dart';
import 'package:flutter_demo/model/home_model.dart';
import 'package:flutter_demo/model/sales_box_model.dart';
import 'package:flutter_demo/pages/search_page.dart';
import 'package:flutter_demo/widget/grid_nav.dart';
import 'package:flutter_demo/widget/loading_container.dart';
import 'package:flutter_demo/widget/local_nav.dart';
import 'package:flutter_demo/widget/sales_box_nav.dart';
import 'package:flutter_demo/widget/search_bar.dart';
import 'package:flutter_demo/widget/sub_nav.dart';
import 'package:flutter_demo/widget/webview.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

const appBarScorllOffset = 150;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _appBarOpacity = 0;
  String resultString = "";
  ConfigModel _config;
  List<CommonModel> _bannerList = [];
  List<CommonModel> _localNavList = [];

  GridNavModel _gridNav;
  List<CommonModel> _subNavList = [];
  SalesBoxModel _salesBox;
  bool _isLoading = true;
  Future<Null> _loadData() async {
    try {
      HomeModel result = await HomeDao.fetch();
      print(result.bannerList);
      setState(() {
        _bannerList = result.bannerList;
        _localNavList = result.localNavList;
        _config = result.config;
        _gridNav = result.gridNav;
        _subNavList = result.subNavList;
        _salesBox = result.salesBox;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _onScroll(offset) {
    // print(offset);
    double opacity = offset / appBarScorllOffset;
    if (opacity < 0) {
      opacity = 0;
    } else if (opacity > 1) {
      opacity = 1;
    }
    setState(() {
      _appBarOpacity = opacity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xf2f2f2f2),
        body: LoadingContainer(
            isLoading: _isLoading,
            cover: false,
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: RefreshIndicator(
                    onRefresh: _loadData,
                    child: Stack(
                      children: <Widget>[
                        NotificationListener(
                          onNotification: (scrollNotification) {
                            if (scrollNotification
                                    is ScrollUpdateNotification &&
                                scrollNotification.depth == 0) {
                              _onScroll(scrollNotification.metrics.pixels);
                            }
                          },
                          child: _listView,
                        ),
                        //自定义导航栏
                        _appBar,
                      ],
                    )))));
  }

  Widget get _listView {
    return ListView(
      children: <Widget>[
        //轮播图
        _banner,
        //头部导航入口
        Padding(
          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
          child: LocalNav(localNavList: _localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
          child: GridNav(gridNavModel: _gridNav),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
          child: SubNav(subNavList: _subNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 5, 7, 5),
          child: SalesBoxNav(salesBox: _salesBox),
        ),
      ],
    );
  }

  Widget get _banner {
    return Container(
      height: 200,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel item = _bannerList[index];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          WebView(url: item.url, hideAppBar: false)));
            },
            child: new Image.network(
              _bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        itemCount: _bannerList.length,
        pagination: new SwiperPagination(),
        autoplay: true,
      ),
    );
  }

  Widget get _appBar {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              //AppBar渐变遮罩背景
              colors: [Color(0x66000000), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80.0,
            decoration: BoxDecoration(
              color:
                  Color.fromARGB((_appBarOpacity * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchBarType: _appBarOpacity > 0.2
                  ? SearchBarType.homeLight
                  : SearchBarType.home,
              inputBoxClick: _jumpToSearch,
              // speakClick: _jumpToSpeak,
              defaultText: "蔚来汽车",
              leftButtonClick: () {},
            ),
          ),
        ),
        Container(
            height: _appBarOpacity > 0.2 ? 0.5 : 0,
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]))
      ],
    );
  }

  _jumpToSearch() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SearchPage(hideLeft: false,keyword: '上海',)));
  }
}
