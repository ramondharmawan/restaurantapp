import 'package:flutter/material.dart';
import 'package:restaurant_app/menus.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_page';
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            if (snapshot.data != null) {
              final welcome = Welcome.fromRawJson(snapshot.data!);

              return ListView.builder(
                  itemCount: welcome.restaurants.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding:
                          const EdgeInsets.only(top: 5, bottom: 5, left: 10),
                      leading: Image.network(
                        welcome.restaurants[index].pictureId,
                        width: 65,
                      ),
                      title: Text(welcome.restaurants[index].name),
                    );
                  });
            } else {
              return const Center(child: Text('Error: data is Null'));
            }
          }
        },
      ),
    );
  }
}
