
class CommonModel {
  final String icon;
  final String title;
  final String statusBarColor;
  final String url;
  final bool hideAppBar;

  CommonModel(
      {this.statusBarColor, this.url, this.hideAppBar, this.icon, this.title});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      statusBarColor: json['statusBarColor'],
      url: json['url'],
      hideAppBar: json['hideAppBar'],
      icon: json['icon'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusBarColor'] = this.statusBarColor;
    data['url'] = this.url;
    data['hideAppBar'] = this.hideAppBar;
    data['icon'] = this.icon;
    data['title'] = this.title;

    return data;
  }
}
