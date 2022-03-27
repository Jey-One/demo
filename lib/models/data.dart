class Data {
  String? highestUvOfTheDay;
  String? rangeOfHoursWithUv;
  String? temperature;
  String? uv;
  String? hour;
  Data(
      {this.highestUvOfTheDay,
      this.rangeOfHoursWithUv,
      this.temperature,
      this.uv,
      this.hour});

  Data.fromJson(Map<String, dynamic> json) {
    highestUvOfTheDay = json['highestUvOfTheDay'];
    rangeOfHoursWithUv = json['rangeOfHoursWithUv'];
    temperature = json['temperature'];
    uv = json['uv'];
    hour = json['hour'];
  }

  Map<String, dynamic> toMap() {
    return {
      'highestUvOfTheDay': highestUvOfTheDay,
      'rangeOfHoursWithUv': rangeOfHoursWithUv,
      'temperature': temperature,
      'uv': uv,
      'hour': hour
    };
  }
}
