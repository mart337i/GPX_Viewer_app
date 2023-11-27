class Trail {
  final String name;
  final String? location;
  final String? imageUrl;
  final double length;
  final String estimatedTime;

  Trail({
    required this.name,
    this.location,
    this.imageUrl,
    required this.length,
    required this.estimatedTime,
  });

  factory Trail.fromJson(Map<String, dynamic> json) {
    return Trail(
      name: json['name'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      length: json['length'].toDouble(),
      estimatedTime: json['estimatedTime'],
    );
  }
}


