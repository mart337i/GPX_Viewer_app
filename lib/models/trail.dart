class Trail {
  final String name;
  final String filename;
  final String? location;
  final String? imageUrl;
  final double length;
  final String estimatedTime;

  Trail({
    required this.name,
    required this.filename,
    this.location,
    this.imageUrl,
    required this.length,
    required this.estimatedTime,
  });

  factory Trail.fromJson(Map<String, dynamic> json) {
    return Trail(
      name: json['name'],
      filename: json['filename'],
      location: json['location'],
      imageUrl: json['imageUrl'],
      length: json['length'].toDouble(),
      estimatedTime: json['estimatedTime'],
    );
  }
}


