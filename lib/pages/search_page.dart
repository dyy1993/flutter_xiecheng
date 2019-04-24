import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/search_dao.dart';
import 'package:flutter_demo/model/search_model.dart';
import 'package:flutter_demo/widget/search_bar.dart';
import 'package:flutter_demo/widget/webview.dart';

const SEARCH_URL =
    'https://m.ctrip.com/restapi/h5api/searchapp/search?source=mobileweb&action=autocomplete&contentType=json&keyword=';
const TYPES = [
  'channelplane',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup',
  'channelgroup',
  'channelgs',
  'channeltrain',
  'cruise'
];

class SearchPage extends StatefulWidget {
  final bool hideLeft;
  final String searchUrl;
  final String keyword;
  final String hint;

  const SearchPage(
      {Key key, this.hideLeft, this.searchUrl, this.keyword, this.hint})
      : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchModel searchModel;
  String keyword;

  // ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //       _scrollController.position.maxScrollExtent) {
    //     _loadMoreData();
    //   }
    // });
    if (widget.keyword != null) {
      _onTextChange(widget.keyword);
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(color: Color(0xffeeeeee)),
            child: Column(
              children: <Widget>[
                _appBar(),
                MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  child: Expanded(
                    flex: 1,
                    child: ListView.builder(
                      itemCount: searchModel?.data?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        return _item(index);
                      },
                    ),
                  ),
                )
              ],
            )));
  }

  _appBar() {
    return Container(
        height: 88,
        padding: EdgeInsets.only(top: 40),
        decoration: BoxDecoration(color: Colors.white),
        child: SearchBar(
          hideLeft: widget.hideLeft,
          searchBarType: SearchBarType.normal,
          onChanged: _onTextChange,
          leftButtonClick: _leftButtonClick,
          defaultText: widget.keyword,
          hint: '请输入搜索内容',
        ));
  }

  _leftButtonClick() {
    Navigator.pop(context);
  }

  _item(int index) {
    if (searchModel == null || searchModel.data == null) return null;
    SearchItem searchItem = searchModel.data[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WebView(url: searchItem.url, title: "详情")));
      },
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(5),
              child: Image(
                image: AssetImage(_getImagePath(searchItem.type)),
                width: 30,
                height: 30,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 300,
                    child: _title(searchItem),
                  ),
                  Container(
                    width: 300,
                    margin: EdgeInsets.only(top: 8),
                    child: _subTitle(searchItem),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _onTextChange(String text) {
    keyword = text;

    if (text.length == 0) {
      setState(() {
        searchModel = null;
      });
      return;
    }
    SearchDao.fetch(SEARCH_URL + text, text).then((SearchModel model) {
      if (model.keyWord == keyword) {
        setState(() {
          searchModel = model;
        });
      }
    }).catchError((e) {
      print(e);
    });
  }

  String _getImagePath(String type) {
    if (type == null || type.length == 0) return "images/type_travelgroup.png";
    String path = "travelgroup";
    for (var val in TYPES) {
      if (type.contains(val)) {
        path = val;
        break;
      }
    }
    return "images/type_$path.png";
  }

  _title(SearchItem item) {
    if (item.word == null) return null;
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(item.word, searchModel.keyWord));
    spans.add(TextSpan(
        text: ' ' + (item.districtname ?? '') + ' ' + (item.zonename ?? ''),
        style: TextStyle(fontSize: 16, color: Colors.grey)));
    return RichText(
      text: TextSpan(children: spans),
    );
  }

  _subTitle(SearchItem item) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: item.price ?? '',
            style: TextStyle(fontSize: 13, color: Colors.orange)),
        TextSpan(
            text: ' ' + (item.star ?? ''),
            style: TextStyle(fontSize: 13, color: Colors.grey))
      ]),
    );
  }

  _keywordTextSpans(String word, String keyword) {
    List<TextSpan> spans = [];
    print(word);
    if (word == null || word.length == 0) return spans;
    List<String> words = word.split(keyword);

    for (int i = 0; i < words.length; i++) {
      String word = words[i];

      if ((i + 1) % 2 == 0) {
        spans.add(TextSpan(
            text: keyword,
            style: TextStyle(fontSize: 16, color: Colors.orange)));
      }
      if (word == null || word.length == 0) continue;
      spans.add(TextSpan(
          text: word, style: TextStyle(fontSize: 16, color: Colors.black54)));
    }
    return spans;
  }
}
