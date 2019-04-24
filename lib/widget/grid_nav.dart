import 'package:flutter/material.dart';
import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/model/grid_nav_model.dart';
import 'package:flutter_demo/model/sub_grid_model.dart';
import 'package:flutter_demo/widget/webview.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, @required this.gridNavModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _navItems(context),
      ),
    );
  }

  _navItems(BuildContext context) {
    List<Widget> items = [];
    if (gridNavModel == null) return items;
    if (gridNavModel.hotel != null) {
      items.add(_navItem(context, gridNavModel.hotel, true));
    }
    if (gridNavModel.flight != null) {
      items.add(_navItem(context, gridNavModel.flight, false));
    }
    if (gridNavModel.travel != null) {
      items.add(_navItem(context, gridNavModel.travel, false));
    }
    return items;
  }

  Widget _navItem(BuildContext context, SubGridModel gridModel, bool first) {
    List<Widget> items = [];
    items.add(Expanded(flex: 1, child: _mainItem(context, gridModel.mainItem)));
    items.add(Expanded(
        flex: 1,
        child: _doubleItem(context, gridModel.item1, gridModel.item2)));
    items.add(Expanded(
        flex: 1,
        child: _doubleItem(context, gridModel.item3, gridModel.item4)));

    Color startColor = Color(int.parse('0xff' + gridModel.startColor));
    Color endColor = Color(int.parse('0xff' + gridModel.endColor));
    return Container(
      height: 90,
      margin: first ? null : EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: items,
      ),
    );
  }

  Widget _mainItem(BuildContext context, CommonModel item) {
    return _wrapGesture(
        context,
        item,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              item.icon,
              fit: BoxFit.contain,
              alignment: AlignmentDirectional.bottomEnd,
              width: 120,
              height: 90,
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                item.title,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            )
          ],
        ));
  }

  Widget _doubleItem(
      BuildContext context, CommonModel firstItem, CommonModel secondItem) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: _item(context, firstItem, true),
        ),
        Expanded(
          child: _item(context, secondItem, false),
        )
      ],
    );
  }

  Widget _item(BuildContext context, CommonModel item, bool isTop) {
    BorderSide borderSide = BorderSide(color: Colors.white, width: 0.5);
    return _wrapGesture(
        context,
        item,
        FractionallySizedBox(
          widthFactor: 1,
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    left: borderSide,
                    bottom: isTop ? borderSide : BorderSide.none)),
            child: Center(
              child: Text(item.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.black)),
            ),
          ),
        ));
  }

  _wrapGesture(BuildContext context, CommonModel item, Widget widget) {
    return GestureDetector(
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
      child: widget,
    );
  }
}
