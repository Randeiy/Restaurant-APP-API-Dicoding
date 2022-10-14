import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latihan2_randy/common/constant.dart';
import 'package:latihan2_randy/data/api/api_service.dart';
import 'package:latihan2_randy/provider/restaurant_detail.dart';
import 'package:latihan2_randy/widgets/restaurant_detail.dart';
import 'package:latihan2_randy/data/model/restaurant_list.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restauran_detail';
  final Restaurantlist restaurantlist;

  const RestaurantDetailPage({Key? key, required this.restaurantlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        foregroundColor: Colors.white,
        title: const Text(
          "Restaurant",
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: ChangeNotifierProvider<DetailRestaurantProvider>(
        create: (_) => DetailRestaurantProvider(
            apiService: ApiService(), id: restaurantlist.id),
        child: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return RestaurantDetail(
                restaurant: state.result.restaurants,
                restaurantlist: restaurantlist,
              );
            } else if (state.state == ResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Sorry, please check your internet connection.'));
            }
          },
        ),
      ),
    );
  }
}