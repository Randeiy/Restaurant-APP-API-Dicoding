import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latihan2_randy/common/constant.dart';
import 'package:latihan2_randy/data/api/api_service.dart';
import 'package:latihan2_randy/data/model/restaurant_detail.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  late DetailRestaurantResult _detailRestaurant;
  late ResultState _state;
  String _message = '';

  DetailRestaurantProvider({required this.id, required this.apiService}) {
    getDetailRestaurant(id);
  }

  String get message => _message;
  DetailRestaurantResult get result => _detailRestaurant;
  ResultState get state => _state;

  Future<dynamic> getDetailRestaurant(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.getDetailId(id);
      if (detailRestaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailRestaurant = detailRestaurant;
      }
    } on SocketException {
      _state = ResultState.error;
      notifyListeners();
      return _message = "No internet connection";
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = e.toString();
    }
  }
}
