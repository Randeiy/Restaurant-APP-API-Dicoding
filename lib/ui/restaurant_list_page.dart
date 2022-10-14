import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latihan2_randy/common/constant.dart';
import 'package:latihan2_randy/provider/restaurant_list.dart';
import 'package:latihan2_randy/widgets/restaurant_list.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restauran_list';
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(
              child: Text('Sorry, please check your internet connection.'));
        }
      },
    );
  }
}