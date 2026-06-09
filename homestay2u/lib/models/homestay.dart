class Homestay {
  final int id;
  final String name;
  final String state;
  final String district;
  final String town;
  final String address;
  final String description;
  final double priceMin;
  final String imageUrl;
  final List<String> activities;
  final List<String> amenities;

  Homestay({
    required this.id,
    required this.name,
    required this.state,
    required this.district,
    required this.town,
    required this.address,
    required this.description,
    required this.priceMin,
    required this.imageUrl,
    required this.activities,
    required this.amenities,
  });

  factory Homestay.fromJson(Map<String, dynamic> json) {
    return Homestay(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      state: json['state'] ?? '',
      district: json['district'] ?? '',
      town: json['town'] ?? '',
      address: json['address'] ?? '',
      description: json['description'] ?? '',
      priceMin: (json['price_min'] ?? 0).toDouble(),
      imageUrl: json['image_url'] ?? '',
      activities: List<String>.from(json['activities'] ?? []),
      amenities: List<String>.from(json['amenities'] ?? []),
    );
  }
}