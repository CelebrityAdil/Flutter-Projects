import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tourism_app/data/simple_data.dart';
import 'package:tourism_app/screens/calender_screen.dart';
import 'package:tourism_app/screens/detail_screen.dart';
import 'package:tourism_app/screens/message_screen.dart';
import '../widgets/tour_card.dart';
import '../models/tour.dart';
import 'profile_screen.dart';
import 'notification_screen.dart';
import 'package:tourism_app/screens/favourites_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Tour> tours = sampleTours;
  Set<String> favorites = {};

  final String profileImageUrl =
      'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=800&q=80';

  final String randomUserName = 'Hareem Gul';

  void toggleFavorite(String id) {
    setState(() {
      if (favorites.contains(id)) {
        favorites.remove(id);
      } else {
        favorites.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final userName = args?['username'] ?? randomUserName;
    final email = args?['email'] ?? 'guest@example.com';
    final size = MediaQuery.of(context).size;
    final isSmallDevice = size.height < 720 || size.width < 380;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==== TOP BAR (Profile + Notification + Favorites) ====
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Profile Picture
                        CircleAvatar(
                          radius: isSmallDevice ? 24 : 28,
                          backgroundImage: NetworkImage(profileImageUrl),
                        ),
                        const SizedBox(width: 10),
                        // User Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hi, $userName 👋',
                              style: GoogleFonts.poppins(
                                fontSize: isSmallDevice ? 15 : 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Welcome back!',
                              style: TextStyle(
                                fontSize: isSmallDevice ? 12 : 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          iconSize: isSmallDevice ? 23 : 30,
                          color: Colors.redAccent,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              FavoritesScreen.routeName,
                              arguments: favorites, // pass favorites set
                            );
                          },
                        ),
                        const SizedBox(width: 5),
                        // Notification Icon
                        IconButton(
                          icon: const Icon(Icons.notifications_none),
                          iconSize: isSmallDevice ? 23 : 30,
                          color: const Color.fromARGB(255, 59, 9, 207),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) => NotificationScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Explore the',
                        style: GoogleFonts.poppins(
                          fontSize: isSmallDevice ? 24 : 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[700],
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'Beautiful ',
                          style: GoogleFonts.poppins(
                            fontSize: isSmallDevice ? 28 : 34,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            height: 1.2,
                          ),
                          children: [
                            TextSpan(
                              text: 'World!',
                              style: GoogleFonts.poppins(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Best Destination',
                      style: GoogleFonts.poppins(
                        fontSize: isSmallDevice ? 18 : 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View all',
                        style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: isSmallDevice ? 13 : 15,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: isSmallDevice ? 380 : 460,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: tours.length,
                    itemBuilder: (ctx, i) {
                      final tour = tours[i];
                      final isFav = favorites.contains(tour.id);

                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            DetailScreen.routeName,
                            arguments: tour,
                          );
                        },
                        child: Container(
                          width: isSmallDevice ? 240 : 280,
                          margin: const EdgeInsets.only(right: 18),
                          child: TourCard(
                            tour: tour,
                            isFavorite: isFav,
                            onFavoriteToggle: () => toggleFavorite(tour.id),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => const CalendarScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (ctx) => const MessageScreen()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) =>
                    ProfileScreen(username: userName, email: email),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message_outlined),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
