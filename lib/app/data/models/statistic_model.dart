class Statistic {
  int? studentTripCount;
  int? studentTripNotUseCount;
  num? distance;

  String get distanceStr {
    if (distance != null) {
      double value = distance! / 1000;
      return value.toStringAsFixed(1);
    } else {
      return '0.0';
    }
  }

  Statistic(
      {this.studentTripCount, this.studentTripNotUseCount, this.distance});

  Statistic.fromJson(Map<String, dynamic> json) {
    studentTripCount = json['studentTripCount'];
    studentTripNotUseCount = json['studentTripNotUseCount'];
    distance = json['distance'];
  }
}
