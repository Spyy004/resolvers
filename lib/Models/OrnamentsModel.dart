class Ornaments {
  bool success;
  int timestamp;
  String date;
  String base;
  Rates rates;
  String unit;

  Ornaments(
      {this.success,
        this.timestamp,
        this.date,
        this.base,
        this.rates,
        this.unit});

  Ornaments.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    timestamp = json['timestamp'];
    date = json['date'];
    base = json['base'];
    rates = json['rates'] != null ? new Rates.fromJson(json['rates']) : null;
    unit = json['unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['timestamp'] = this.timestamp;
    data['date'] = this.date;
    data['base'] = this.base;
    if (this.rates != null) {
      data['rates'] = this.rates.toJson();
    }
    data['unit'] = this.unit;
    return data;
  }
}

class Rates {
  double xAG;
  double xAU;

  Rates({this.xAG, this.xAU});

  Rates.fromJson(Map<String, dynamic> json) {
    xAG = json['XAG'];
    xAU = json['XAU'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['XAG'] = this.xAG;
    data['XAU'] = this.xAU;
    return data;
  }
}
