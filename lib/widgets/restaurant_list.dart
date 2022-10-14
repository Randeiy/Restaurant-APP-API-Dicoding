import 'package:flutter/material.dart';
import 'package:latihan2_randy/data/model/restaurant_list.dart';
import 'package:latihan2_randy/common/navigation.dart';
import 'package:latihan2_randy/provider/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:latihan2_randy/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurantlist restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Material(
              child :Card(
              child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                    "https://restaurant-api.dicoding.dev/images/large/" +
                        restaurant.pictureId,
                    width: 100,
                  ),
                ),
                title: Text(
                  restaurant.name,
                ),
                subtitle: Text(restaurant.city),
                trailing: isBookmarked
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.removeFavorite(restaurant.id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        color: Theme.of(context).colorScheme.secondary,
                        onPressed: () => provider.addFavorite(restaurant),
                      ),
                onTap: () => Navigation.intentWithData(
                    RestaurantDetailPage.routeName, restaurant),
              ),
            ));
          },
        );
      },
    );
  }
}

Row iconWithText(BuildContext context, {IconData? icon, required String text}) {
  return Row(
    children: [
      Icon(
        icon,
        size: 15,
        color: Colors.blueGrey,
      ),
      Text(
        text,
        style: Theme.of(context)
            .textTheme
            .button
            ?.copyWith(color: Colors.deepPurple),
      ),
    ],
  );
}
