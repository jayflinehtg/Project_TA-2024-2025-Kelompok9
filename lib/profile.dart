import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const String publicKey = "1234567898yrfg876543456thg";

    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E9), // Warna latar belakang diperbaiki
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFA4D4AE),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF498553),
              ),
            ),
            const SizedBox(height: 30), // Memberi jarak lebih panjang
            GestureDetector(
              onTap: () {
                Clipboard.setData(const ClipboardData(text: publicKey));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Public Key disalin!')),
                );
              },
              child: Text(
                'Public Key: $publicKey',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  decoration: TextDecoration.underline, // Efek bisa diklik
                ),
              ),
            ),
            const SizedBox(height: 12), // Jarak sebelum email
            const Text(
              'pengguna@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 36),
            SizedBox(
              width: 140,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}