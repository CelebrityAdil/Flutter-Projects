// lib/screens/message_screen.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {
        'name': 'Leonardo',
        'message': 'Hey! How was your trip to Niladri?',
        'time': '9:30 AM',
        'unread': 2,
        'avatar':
            'https://images.unsplash.com/photo-1502767089025-6572583495b4?auto=format&fit=crop&w=600&q=80',
      },
      {
        'name': 'Sophia',
        'message': 'Are you joining the Sunamganj tour tomorrow?',
        'time': '8:15 AM',
        'unread': 0,
        'avatar':
            'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=600&q=80',
      },
      {
        'name': 'James',
        'message': 'Thanks for the travel tips!',
        'time': 'Yesterday',
        'unread': 1,
        'avatar':
            'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
      },
      {
        'name': 'Emma',
        'message': 'Can we make video call at  weekend?',
        'time': 'Sun',
        'unread': 0,
        'avatar':
            'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=600&q=80',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final Map<String, dynamic> msg = messages[index];

          final String name = (msg['name'] ?? 'Unknown').toString();
          final String lastMessage = (msg['message'] ?? '').toString();
          final String time = (msg['time'] ?? '').toString();
          final int unread = (msg['unread'] is int)
              ? msg['unread'] as int
              : int.tryParse((msg['unread'] ?? '0').toString()) ?? 0;
          final String? avatarUrl = (msg['avatar'] != null)
              ? msg['avatar'].toString()
              : null;

          final bool hasUnread = unread > 0;

          return Card(
            elevation: 2,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: avatarUrl != null
                    ? NetworkImage(avatarUrl)
                    : null,
                child: avatarUrl == null
                    ? Text(name.isNotEmpty ? name[0] : '?')
                    : null,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
              subtitle: Row(
                children: [
                  Expanded(
                    child: Text(
                      lastMessage,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.grey[700],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  if (hasUnread)
                    Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        unread.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening chat with $name...')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
