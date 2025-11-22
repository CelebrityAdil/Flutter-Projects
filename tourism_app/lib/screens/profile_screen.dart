import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  final String username;
  final String email;

  const ProfileScreen({super.key, required this.username, required this.email});

  @override
  Widget build(BuildContext context) {
    const profileImageUrl =
        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?auto=format&fit=crop&w=800&q=80';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Done', style: TextStyle(color: Colors.teal)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CircleAvatar(
              radius: 55,
              backgroundImage: NetworkImage(profileImageUrl),
              backgroundColor: Colors.grey[200],
              onBackgroundImageError: (_, __) {},
            ),
            const SizedBox(height: 10),

            Text(
              username,
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Change Profile Picture',
                style: TextStyle(color: Colors.teal),
              ),
            ),
            const SizedBox(height: 20),

            // Profile fields
            _ProfileTextField(
              label: 'First Name',
              value: username.split(' ').first,
            ),
            _ProfileTextField(
              label: 'Last Name',
              value: username.split(' ').length > 1
                  ? username.split(' ').last
                  : '',
            ),
            _ProfileTextField(label: 'Location', value: 'Sylhet, Bangladesh'),
            _ProfileTextField(
              label: 'Mobile Number',
              value: '+88 01758-000666',
            ),
            _ProfileTextField(label: 'Email', value: email),
          ],
        ),
      ),
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  final String label;
  final String value;
  const _ProfileTextField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: value,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.check_circle, color: Colors.teal),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}
