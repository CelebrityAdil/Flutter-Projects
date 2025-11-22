import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = List.generate(6, (index) {
    return {
      'title': 'Super Offer',
      'message': 'Get 60% off in our first booking',
      'time': 'Sun, 12:40pm',
      'avatar': 'https://randomuser.me/api/portraits/lego/${index + 1}.jpg',
    };
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Notification'),
          actions: [
            TextButton(
              onPressed: () {},
              child: Text('Clear all', style: TextStyle(color: Colors.teal)),
            ),
          ],
          bottom: const TabBar(
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: 'Recent'),
              Tab(text: 'Earlier'),
              Tab(text: 'Archived'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildNotificationList(),
            _buildNotificationList(),
            _buildNotificationList(),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: notifications.length,
      itemBuilder: (ctx, i) {
        final note = notifications[i];
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(note['avatar']!),
            ),
            title: Text(
              note['title']!,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(note['message']!),
            trailing: Text(
              note['time']!,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
            ),
          ),
        );
      },
    );
  }
}
