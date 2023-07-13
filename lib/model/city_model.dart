class City {
  final int? id;
  final String? name;
  final String? country;
  final double? lon;
  final double? lat;

  City({
     this.id,
     this.name,
     this.country,
     this.lon,
     this.lat,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'],
      name: json['name'],
      country: json['sys']['country'],
      lon: json['coord']['lon'].toDouble(),
      lat: json['coord']['lat'].toDouble(),
    );
  }
}
