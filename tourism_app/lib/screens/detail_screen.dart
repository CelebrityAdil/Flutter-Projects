import 'package:flutter/material.dart';
import '../models/tour.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';
  final Tour tour;
  const DetailScreen({Key? key, required this.tour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tour.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                tour.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) {
                  return Container(
                    color: Colors.grey,
                    child: Icon(Icons.photo, size: 64),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          tour.title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '\$${tour.price.toStringAsFixed(0)}',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(color: Colors.teal),
                          ),
                          Text(
                            '${tour.durationDays} days',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 18),
                      SizedBox(width: 4),
                      Text(tour.location),
                      SizedBox(width: 12),
                      Icon(Icons.star, size: 18, color: Colors.orange),
                      SizedBox(width: 4),
                      Text('${tour.rating}'),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Overview',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  Text(
                    tour.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      final snack = SnackBar(
                        content: Text('Booking not implemented — demo only.'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snack);
                    },
                    icon: Icon(Icons.shopping_bag_outlined),
                    label: Text('Book Now'),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Gallery',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (ctx, i) => ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          tour.imageUrl,
                          width: 140,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(color: Colors.grey),
                        ),
                      ),
                      separatorBuilder: (_, __) => SizedBox(width: 8),
                      itemCount: 4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
