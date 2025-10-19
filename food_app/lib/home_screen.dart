import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_app/chatbot_screen.dart';
import 'package:http/http.dart' as http;

// --- CONFIGURATION ---
// IMPORTANT: Replace these placeholders with your actual values.
const String PEXELS_API_KEY =
    '1ugnWFbJCtZ51EtopnclckU7kr31WVe3apTYHkCuSVjrgnKIDguZ1nuV';
const String CHATBOT_SERVER_URL =
    'https://untameable-shanita-unusurping.ngrok-free.dev';
// Use 10.0.2.2 for Android emulator to access localhost

class FoodPhoto {
  final String id;
  final String description;
  final String url;

  FoodPhoto({required this.id, required this.description, required this.url});

  factory FoodPhoto.fromJson(Map<String, dynamic> json) {
    return FoodPhoto(
      id: json['id'],
      description: json['alt_description'] ?? 'Delicious Food',
      url: json['urls']['small'],
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}

// --- HOME SCREEN (Food Grid) ---

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<FoodPhoto>> _foodPhotos;

  @override
  void initState() {
    super.initState();
    _foodPhotos = _fetchFoodPhotos();
  }

  // Fetches food photos from Unsplash API
  Future<List<FoodPhoto>> _fetchFoodPhotos() async {
    // Only proceed if a key is provided
    if (PEXELS_API_KEY == 'YOUR_PEXELS_API_KEY') {
      return Future.error('Please set your PEXELS_API_KEY');
    }

    const String query = 'food';
    const int count = 30; // Number of photos to fetch

    // Pexels API search endpoint
    final String url =
        'https://api.pexels.com/v1/search?query=$query&per_page=$count';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          // Pexels requires the API key in the Authorization header
          'Authorization': PEXELS_API_KEY,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // Pexels returns the list of photos under the 'photos' key
        final List results = data['photos'];

        // Map the results list to a list of FoodPhoto objects
        return results.map((json) => FoodPhoto.fromJson(json)).toList();
      } else {
        // Handle server errors
        throw Exception(
          'Failed to load photos. Status: ${response.statusCode}',
        );
      }
    } catch (e) {
      // Handle network or parsing errors
      debugPrint('Error fetching photos: $e');
      return Future.error('Network Error or Invalid API Key: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Explorer'),
        backgroundColor: Colors.green.shade600,
        elevation: 0,
      ),
      body: FutureBuilder<List<FoodPhoto>>(
        future: _foodPhotos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 0.8, // Adjust ratio for better look
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final photo = snapshot.data![index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            photo.url,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) =>
                                const Center(
                                  child: Icon(Icons.broken_image, size: 40),
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            photo.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No food photos found.'));
          }
        },
      ),

      // Floating Action Button to open the Chatbot
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
        icon: const Icon(Icons.message_rounded),
        label: const Text('Chatbot'),
        backgroundColor: Colors.green.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
      ),
    );
  }
}
