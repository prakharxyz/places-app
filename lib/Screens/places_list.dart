import 'package:flutter/material.dart';
import 'package:places_app/Providers/place_provider.dart';
import 'package:places_app/Screens/add_new_place.dart';
import 'package:provider/provider.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Places'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlace.routeName);
              })
        ],
      ),
      body: FutureBuilder(
          future: Provider.of<PlacesProvider>(context).fetchAndSetProducts(),
          builder: (context, snapshot) {
            return snapshot.connectionState == AsyncSnapshot.waiting()
                ? Center(child: CircularProgressIndicator())
                : Consumer<PlacesProvider>(
                    builder: (ctx, provider, ch) => ListView.builder(
                      itemBuilder: (ctx, i) => ListTile(
                        title: Text(provider.list[i].title),
                        leading: Image.file(
                          provider.list[i].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      itemCount: provider.list.length,
                    ),
                  );
          }),
    );
  }
}
