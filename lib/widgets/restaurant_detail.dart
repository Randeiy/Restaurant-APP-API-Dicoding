import 'package:flutter/material.dart';
import 'package:latihan2_randy/common/style.dart';
import 'package:latihan2_randy/data/model/restaurant_detail.dart';
import 'package:latihan2_randy/data/model/restaurant_list.dart';

class RestaurantDetail extends StatelessWidget {
  final Restaurant restaurant;
  final Restaurantlist restaurantlist;

  const RestaurantDetail(
      {Key? key, required this.restaurant, required this.restaurantlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Card(
        child: Column(
          children: <Widget>[
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/medium/" +
                    restaurant.pictureId,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            restaurant.name,
                            style: myTextTheme.headline5,
                          ),
                          _sizebox(10),
                          Row(
                            children: [
                              _icon(Icons.location_on, 20, Colors.black),
                              Text(
                                ' ${restaurant.city}',
                                style: myTextTheme.bodyText1,
                              ),
                            ],
                          ),
                          _sizebox(10),
                          Row(
                            children: [
                              _icon(Icons.star_rate, 20, Colors.black),
                              Text(
                                ' ${restaurant.rating}',
                                style: myTextTheme.bodyText1,
                              ),
                            ],
                          ),
                          _sizebox(10),
                          Row(
                            children: [
                              _icon(Icons.book, 20, Colors.black),
                              Text(
                                '${restaurant.id}',
                                style: myTextTheme.bodyText2,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                _barrierContent(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 10, right: 20, left: 20),
                      child: Text('Description', style: myTextTheme.headline6),
                    ),
                    Container(
                        padding: const EdgeInsets.only(
                            top: 10, right: 20, left: 20, bottom: 20),
                        width: double.infinity,
                        child: Text(restaurant.description,
                            style: myTextTheme.bodyText2)),
                  ],
                ),
                _barrierContent(),
                _sizebox(10),
                Text(
                  '    Foods menu : ',
                  style: myTextTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 70,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5),
                  padding: const EdgeInsets.only(
                      top: 10, right: 20, left: 20, bottom: 20),
                  itemCount: restaurant.menus.foods.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Card(
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              restaurant.menus.foods[index].name,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(color: Colors.black),
                Text('    Drinks menu : ', style: myTextTheme.headline6),
                const SizedBox(
                  height: 10,
                ),
                GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 70,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 5),
                  padding: const EdgeInsets.only(
                      top: 10, right: 20, left: 20, bottom: 20),
                  itemCount: restaurant.menus.drinks.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Card(
                      child: Column(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Text(
                              restaurant.menus.drinks[index].name,
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                _barrierContent(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.only(top: 5, right: 20, left: 20),
                      child: Text('Comment', style: myTextTheme.headline6),
                    ),
                    ListBody(
                      children: restaurant.customerReviews.map((review) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 5, right: 20, left: 20, bottom: 5),
                          child: Row(
                            children: [
                              Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amber),
                                child: Center(
                                    child: Text(
                                  review.name.characters.elementAt(0),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                              ),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                            child: Text(
                                          review.name,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        Text(
                                          ' ${review.date}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey.shade500),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: 300,
                                      child: Text(
                                        review.review,
                                        style: myTextTheme.overline,
                                        overflow: TextOverflow.visible,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                _barrierContent()
              ],
            ),
          ],
        ),
      )),
    );
  }
}

Widget _barrierContent() {
  return Container(
    height: 10,
    color: Colors.grey.shade200,
  );
}

Widget _sizebox(double height) {
  return SizedBox(
    height: height,
  );
}

Widget _icon(IconData icon, double size, Color color) {
  return Icon(
    icon,
    size: size,
    color: color,
  );
}
