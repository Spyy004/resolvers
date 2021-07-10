class StockPrices {
  String stockType;
  String name;
  String lTP;
  String change;
  String pChange;

  StockPrices({this.stockType, this.name, this.lTP, this.change, this.pChange});

  StockPrices.fromJson(Map<String, dynamic> json) {
    stockType = json['stock_type'];
    name = json['name'];
    lTP = json['LTP'];
    change = json['change'];
    pChange = json['pChange'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stock_type'] = this.stockType;
    data['name'] = this.name;
    data['LTP'] = this.lTP;
    data['change'] = this.change;
    data['pChange'] = this.pChange;
    return data;
  }
}
