import 'package:flutter_demo/model/common_model.dart';
import 'package:flutter_demo/model/config_model.dart';
import 'package:flutter_demo/model/grid_nav_model.dart';
import 'package:flutter_demo/model/sales_box_model.dart';

class HomeModel {
  ConfigModel config;
  List<CommonModel> bannerList;
  List<CommonModel> localNavList;

  GridNavModel gridNav;
  List<CommonModel> subNavList;
  SalesBoxModel salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  HomeModel.fromJson(Map<String, dynamic> json) {
    config =
        json['config'] != null ? new ConfigModel.fromJson(json['config']) : null;
    if (json['bannerList'] != null) {
      bannerList = new List<CommonModel>();
      json['bannerList'].forEach((v) {
        bannerList.add(new CommonModel.fromJson(v));
      });
    }
    if (json['localNavList'] != null) {
      localNavList = new List<CommonModel>();
      json['localNavList'].forEach((v) {
        localNavList.add(new CommonModel.fromJson(v));
      });
    }
    gridNav =
        json['gridNav'] != null ? new GridNavModel.fromJson(json['gridNav']) : null;
    if (json['subNavList'] != null) {
      subNavList = new List<CommonModel>();
      json['subNavList'].forEach((v) {
        subNavList.add(new CommonModel.fromJson(v));
      });
    }
    salesBox = json['salesBox'] != null
        ? new SalesBoxModel.fromJson(json['salesBox'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.config != null) {
      data['config'] = this.config.toJson();
    }
    if (this.bannerList != null) {
      data['bannerList'] = this.bannerList.map((v) => v.toJson()).toList();
    }
    if (this.localNavList != null) {
      data['localNavList'] = this.localNavList.map((v) => v.toJson()).toList();
    }
    if (this.gridNav != null) {
      data['gridNav'] = this.gridNav.toJson();
    }
    if (this.subNavList != null) {
      data['subNavList'] = this.subNavList.map((v) => v.toJson()).toList();
    }
    if (this.salesBox != null) {
      data['salesBox'] = this.salesBox.toJson();
    }
    return data;
  }
}
