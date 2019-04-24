import 'package:flutter/material.dart';
import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/model/sales_box_model.dart';
import 'package:flutter_demo/widget/webview.dart';

class SalesBoxNav extends StatelessWidget {
  final SalesBoxModel salesBox;

  const SalesBoxNav({Key key, @required this.salesBox}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: _items(context),
        ));
  }

  Widget _items(BuildContext context) {
    List<Widget> items = [];
    if (salesBox == null) return null;
    items.add(_topItem(context,salesBox));
    items.add(_doubleItem(
        context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    items.add(_doubleItem(
        context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItem(
        context, salesBox.smallCard3, salesBox.smallCard4, false, true));

    return Column(children: items);
  }

  Widget _doubleItem(BuildContext context, CommonModel leftItem,
      CommonModel rightItem, bool big, bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _item(context, leftItem, true, big, last),
        _item(context, leftItem, false, big, last)
      ],
    );
  }

  Widget _topItem(BuildContext context, SalesBoxModel salesBox) {
    return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.network(
              salesBox.icon,
              fit: BoxFit.fill,
              width: 70,
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebView(
                            url: salesBox.moreUrl,
                            title: "更多活动",
                            statusBarColor: "ffffff",
                            hideAppBar: false)));
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.red),
                margin: EdgeInsets.only(left: 10),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: Text("查看更多活动>",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
            )
          ],
        ));
  }

  Widget _item(
      BuildContext context, CommonModel item, bool left, bool big, bool last) {
    BorderSide borderSide = BorderSide(width: 1, color: Color(0xffeeeeee));
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebView(
                      url: item.url,
                      title: item.title,
                      statusBarColor: item.statusBarColor,
                      hideAppBar: item.hideAppBar)));
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: last ? BorderSide.none : borderSide,
                  left: left ? BorderSide.none : borderSide)),
          child: Image.network(
            item.icon,
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width / 2 - 10,
            height: big ? 120 : 80,
          ),
        ),
      ),
    );
  }
}
