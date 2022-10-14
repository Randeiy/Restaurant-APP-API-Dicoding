import 'dart:convert';
import 'package:latihan2_randy/data/model/restaurant_list.dart';

SearchRestaurantResult searchRestaurantResultFromJson(String str) =>
    SearchRestaurantResult.fromJson(json.decode(str));

String searchRestaurantResultToJson(SearchRestaurantResult data) =>
    json.encode(data.toJson());

class SearchRestaurantResult {
  SearchRestaurantResult({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  bool error;
  int founded;
  List<Restaurantlist> restaurants;

  factory SearchRestaurantResult.fromJson(Map<String, dynamic> json) =>
      SearchRestaurantResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurantlist>.from(
            json["restaurants"].map((x) => Restaurantlist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

class RestaurantSearch {
  RestaurantSearch({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantSearch.fromJson(Map<String, dynamic> json) =>
      RestaurantSearch(
          id: json["id"],
          name: json["name"],
          description: json["description"],
          pictureId: json["pictureId"],
          city: json["city"],
          rating: double.parse(json["rating"].toString()));

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}