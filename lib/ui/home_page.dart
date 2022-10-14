import 'package:flutter/material.dart';
import 'package:latihan2_randy/ui/favorite_page.dart';
import 'package:latihan2_randy/ui/restaurant_list_page.dart';
import 'package:latihan2_randy/ui/restaurant_search_page.dart';
import 'package:latihan2_randy/ui/setting_page.dart';

class RestaurantHomePage extends StatefulWidget {
  static const routeName ='/home';
  const RestaurantHomePage({Key? key}) : super(key: key);

  @override
  State<RestaurantHomePage> createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<RestaurantHomePage> {
  int _selectedIndex = 0;
  static const TextStyle myTextTheme =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final List<Widget> _widgetOptions = <Widget>[
    const RestaurantListPage(),
    const RestaurantSearchPage(),
    const RestaurantFavoritePage(),
    const RestaurantSettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //BIKIN CUSTOM APPBAR
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Your Restaurant',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade50,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      unselectedFontSize: 10,
      selectedFontSize: 10,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black.withOpacity(0.5),
      showUnselectedLabels: true,
      showSelectedLabels: true,
      backgroundColor: Colors.white,
      elevation: 5,
      items: const [
        BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: 'Search', icon: Icon(Icons.search)),
        BottomNavigationBarItem(label: 'Favorite', icon: Icon(Icons.favorite)),
        BottomNavigationBarItem(label: 'Setting', icon: Icon(Icons.settings))
      ],
      onTap: (index) {
        _onItemTapped(index);
      },
    );
  }
}
