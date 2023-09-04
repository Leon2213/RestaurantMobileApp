class Restaurang {
  final String name;
  final double longitude;
  final double latitude;
  //final String type;
  final String placeid;
  final String adress;
  final String photoReference;
  final String googleRating;
  final bool isOpen;
  List<String> foodTypes = [];

  List<String> reviews = [];

  Restaurang(
      {required this.name,
      required this.longitude,
      required this.latitude,
      //required this.type,
      required this.adress,
       required this.photoReference,
         required this.placeid,
      required this.googleRating,
      //List<String> foodTypes,
      required this.isOpen});

  factory Restaurang.fromJson(Map<String, dynamic> json) {
    return Restaurang(
      name: json["name"],
      longitude: json["longitude"],
      latitude: json["latitude"],
      adress: json["address"],
      googleRating: json["rating"], // Map<"rating" - 3.5>
      photoReference: json["photoReference"],
      //foodTypes: json['foodTypes'],
      placeid: json["restaurantId"],
      isOpen: json["open"] ?? false,
    );
  }

  void addFoodTypes(String foodType) {
    // "snacks,pizza,hamburgare"
    List<String> foodTypeList = foodType.split(',');
    this.foodTypes = foodTypeList;
  }

  void addReviews(List<String> reviewListKlar) {
    this.reviews = reviewListKlar;
  }


  @override
  String toString() {
    return 'Restaurang{name: $name, longitude: $longitude, latitude: $latitude,  adress: $adress, isOpen: $isOpen, foodType: $foodTypes, reviews: $reviews,photoRef: $photoReference}';
  }
}
