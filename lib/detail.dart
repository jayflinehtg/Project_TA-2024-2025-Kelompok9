import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final String plantName = 'Nama Tanaman Nama Tanaman';
  final String plantContent = 'Kandungan Tanaman Kandungan Tanaman Kandungan Tanaman';
  final String benefits = 'Manfaat Tanaman, Manfaat Tanaman, Manfaat Tanaman';
  final List<String> process = ['Cara pengolahan 1', 'Cara pengolahan 2'];
  final String imageUrl = '';
  bool isLiked = false;
  double userRating = 4.0; // Rating awal pengguna

  List<Map<String, String>> reviews = [
    {
      'username': 'Nama Pengguna 1',
      'review': 'Pengguna 1 Membalas informasi Sebelumnya, Pengguna 1 Membalas informasi Sebelumnya',
      'date': '07 Jan 2025',
    },
    {
      'username': 'Nama Pengguna 2',
      'review': 'Pengguna 2 Membalas informasi Sebelumnya, Pengguna 2 Membalas informasi Sebelumnya',
      'date': '08 Jan 2025',
    },
  ];

  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    String newComment = _commentController.text.trim();
    if (newComment.isNotEmpty) {
      setState(() {
        reviews.add({
          'username': 'Pengguna Baru',
          'review': newComment,
          'date': '10 Jan 2025',
        });
        _commentController.clear();
      });
    }
  }

  Widget _buildRatingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Beri Rating:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        RatingBar.builder(
          initialRating: userRating,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
          onRatingUpdate: (rating) {
            setState(() {
              userRating = rating;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Postingan'),
        backgroundColor: const Color(0xFF9ACAA1),
        actions: [
          IconButton(
            icon: Icon(isLiked ? Icons.favorite : Icons.favorite_border, color: Colors.red),
            onPressed: () {
              setState(() {
                isLiked = !isLiked;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.share, color: Color.fromARGB(255, 7, 148, 50)),
            onPressed: () {
              // Implement share functionality
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFEAF4E9), // Warna latar belakang diperbarui
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                      ),
                      const SizedBox(height: 8),
                      const Text('Nama Pengguna 1', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      const Text('Nama Tanaman:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(plantName),
                      const SizedBox(height: 8),
                      const Text('Kandungan Tanaman:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(plantContent),
                      const SizedBox(height: 8),
                      const Text('Manfaat Tanaman:', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(benefits),
                      const SizedBox(height: 8),
                      const Text('Cara Pengolahan:', style: TextStyle(fontWeight: FontWeight.bold)),
                      for (var item in process) Text(item),
                      const SizedBox(height: 16),
                      Center(
                        child: imageUrl.isNotEmpty
                            ? Image.network(imageUrl)
                            : const Icon(Icons.image, size: 100),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Text('00:21  07 Jan 2025', style: TextStyle(fontSize: 12, color: Colors.grey)),
                          const Spacer(),
                          for (int i = 0; i < 5; i++)
                            Icon(
                              i < userRating.floor() ? Icons.star : Icons.star_border,
                              color: Colors.yellow,
                              size: 20,
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildRatingSection(),
                      const SizedBox(height: 16),
                      const Text('Review Pengguna Lainnya:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      for (var review in reviews)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(review['username']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  Text(review['review']!),
                                  const SizedBox(height: 4),
                                  Text(review['date']!, style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: InputDecoration(
                        hintText: 'Tambahkan Komentar Anda..',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blue),
                    onPressed: _addComment,
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

void main() {
  runApp(MaterialApp(
    home: DetailPage(),
  ));
}