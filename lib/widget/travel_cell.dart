import 'package:flutter/material.dart';
import 'package:flutter_demo/model/travel_model.dart';
import 'package:flutter_demo/widget/webview.dart';

class TravelCell extends StatelessWidget {
  final TravelItem item;

  const TravelCell({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.article.urls != null && item.article.urls.length > 0) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WebView(url: item.article.urls[0].h5Url, title: '详情')));
        }
      },
      child: Card(
          child: PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[_imageView(), _contentView(), _bottomView()],
        ),
      )),
    );
  }

  _imageView() {
    return Stack(
      children: <Widget>[
        Image.network(item.article.images[0]?.dynamicUrl),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            child: Row(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 12,
                    )),
                LimitedBox(
                  //设置容器最大宽度
                  maxWidth: 130,
                  child: Text(
                    _poiName(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  _contentView() {
    return Container(
      padding: EdgeInsets.all(4),
      child: Text(
        item.article.articleTitle,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );
  }

  _bottomView() {
    return Container(
      padding: EdgeInsets.fromLTRB(6, 0, 6, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              PhysicalModel(
                color: Colors.transparent,
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.article.author?.coverImage?.dynamicUrl,
                  width: 24,
                  height: 24,
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                width: 90,
                child: Text(
                  item.article.author?.nickName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Icon(
                Icons.thumb_up,
                size: 14,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.only(left: 3),
                child: Text(
                  item.article.likeCount.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  String _poiName() {
    return item.article.pois == null || item.article.pois.length == 0
        ? '未知'
        : item.article.pois[0]?.poiName ?? '未知';
  }
}
