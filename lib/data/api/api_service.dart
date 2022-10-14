import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan2_randy/data/model/restaurant_detail.dart';
import 'package:latihan2_randy/data/model/restaurant_list.dart';
import 'package:latihan2_randy/data/model/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String baseUrlImage = '${_baseUrl}images/medium/';
  static const String _throw = 'Failed to load data';

  Future<RestaurantResult> topHeadlines() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<DetailRestaurantResult> getDetailId(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return DetailRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }

  Future<SearchRestaurantResult> getTextField(String query) async {
    final response = await http.get(Uri.parse('${_baseUrl}search?q=$query'));
    if (response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception(_throw);
    }
  }
}
