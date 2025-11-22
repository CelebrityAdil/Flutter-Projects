import 'package:flutter/material.dart';
import 'package:tourism_app/data/simple_data.dart';

class FavoritesScreen extends StatelessWidget {
  static const routeName = '/favorites';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final favIds = args is Set<String> ? args : <String>{};

    final favorites = sampleTours.where((t) => favIds.contains(t.id)).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body: favorites.isEmpty
          ? Center(child: Text('No favorites yet — tap the heart on any tour.'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (ctx, i) {
                final t = favorites[i];
                return ListTile(
                  leading: Image.network(
                    t.imageUrl,
                    width: 72,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: Colors.grey),
                  ),
                  title: Text(t.title),
                  subtitle: Text(t.location),
                  trailing: Text('\$${t.price.toStringAsFixed(0)}'),
                  onTap: () =>
                      Navigator.of(context).pushNamed('/detail', arguments: t),
                );
              },
            ),
    );
  }
}
