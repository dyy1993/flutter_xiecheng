import 'package:flutter_demo/model/sub_grid_model.dart';

class GridNavModel {
  SubGridModel hotel;
  SubGridModel flight;
  SubGridModel travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  GridNavModel.fromJson(Map<String, dynamic> json) {
    hotel = json['hotel'] != null ? new SubGridModel.fromJson(json['hotel']) : null;
    flight =
        json['flight'] != null ? new SubGridModel.fromJson(json['flight']) : null;
    travel =
        json['travel'] != null ? new SubGridModel.fromJson(json['travel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hotel != null) {
      data['hotel'] = this.hotel.toJson();
    }
    if (this.flight != null) {
      data['flight'] = this.flight.toJson();
    }
    if (this.travel != null) {
      data['travel'] = this.travel.toJson();
    }
    return data;
  }
}
