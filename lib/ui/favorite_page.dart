import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:latihan2_randy/common/constant.dart';
import 'package:latihan2_randy/widgets/restaurant_list.dart';
import 'package:latihan2_randy/provider/database_provider.dart';

class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              var restaurant = state.favorites[index];
              return CardRestaurant(
                restaurant: restaurant,
              );
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
