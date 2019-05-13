import 'package:flutter/material.dart';
import 'package:flutter_demo/dao/travel_dao.dart';
import 'package:flutter_demo/model/travel_model.dart';
import 'package:flutter_demo/widget/loading_container.dart';
import 'package:flutter_demo/widget/travel_cell.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

const PAGESIZE = 10;
const TRAVEL_URL =
    'https://m.ctrip.com/restapi/soa2/16189/json/searchTripShootListForHomePageV2?_fxpcqlniredt=09031014111431397988&__gw_appid=99999999&__gw_ver=1.0&__gw_from=10650013707&__gw_platform=H5';

class TravelItemPage extends StatefulWidget {
  final String url;
  final String channel;
  final Map params;

  const TravelItemPage({Key key, this.url = '', this.channel, this.params})
      : super(key: key);
  @override
  _TravelItemPageState createState() => _TravelItemPageState();
}

class _TravelItemPageState extends State<TravelItemPage> with AutomaticKeepAliveClientMixin{
  List<TravelItem> travelItems = [];
  bool _loading = true;
  int index = 1;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _loadData();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _loadData({loadMore = false}) {
    if (loadMore) {
      index++;
    } else {
      index = 1;
    }
    print(widget.channel);
    TravelDao.fetchTravel(widget.url ?? TRAVEL_URL, widget.params,
            widget.channel, index, PAGESIZE)
        .then((TravelModel model) {
      List<TravelItem> items = [];
      model.resultList.forEach((item) {
        if (item.article != null) {
          items.add(item);
        }
      });
      setState(() {
        if (travelItems != null) {
          travelItems.addAll(items);
        } else {
          travelItems = items;
        }
        _loading = false;
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _loading = false;
      });
    });
  }

  Future<Null> _handleRefresh() async {
    _loadData();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _loading,
        child: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Container(
                child: new StaggeredGridView.countBuilder(
                  controller: _scrollController,
                  crossAxisCount: 4,
                  itemCount: travelItems.length,
                  itemBuilder: (BuildContext context, int index) =>
                      TravelCell(item: travelItems[index]),
                  staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 2.0,
                ),
              )),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
