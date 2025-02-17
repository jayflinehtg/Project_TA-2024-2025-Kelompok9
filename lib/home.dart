import 'package:flutter/material.dart';
import 'package:project_kelompok9/login.dart';  // Sesuaikan dengan kebutuhan proyek
import 'home.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> herbalPlants = [
    'Jahe', 'Kunyit', 'Temulawak', 'Sambiloto'
  ];
  List<String> filteredPlants = [];

  @override
  void initState() {
    super.initState();
    filteredPlants = List.from(herbalPlants);
  }

  void _filterSearch(String query) {
    setState(() {
      filteredPlants = herbalPlants
          .where((plant) => plant.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E9), // Background sama dengan header
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Full Width
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: const BoxDecoration(
                color: Color(0xFFEAF4E9), // Warna latar belakang soft
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    'Jelajahi Informasi',
                    style: TextStyle(
                      fontSize: 26, // Font lebih besar
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF498553),
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(1, 1),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8), // Slightly larger space for better readability
                  const Text(
                    'Tanaman Herbal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF498553),
                    ),
                  ),
                ],
              ),
            ),

            // Konten setelah header
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  // Search bar
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Cari tanaman...',
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF498553)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xFF498553)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(color: Color(0xFF498553), width: 2),
                      ),
                    ),
                    onChanged: _filterSearch,
                  ),
                  const SizedBox(height: 16),

                  // List tanaman herbal
                  ListView.builder(
                    shrinkWrap: true, // To prevent overflow in the ListView
                    itemCount: filteredPlants.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.transparent, // Membuat kartu transparan agar menyatu dengan background
                        shadowColor: Colors.grey.withOpacity(0.3),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: const Icon(
                              Icons.grass,
                              size: 50,
                              color: Color(0xFF498553),
                            ),
                            title: Text(
                              filteredPlants[index],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF498553),
                              ),
                            ),
                            subtitle: Row(
                              children: List.generate(5, (i) => const Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                    size: 16,
                                  )),
                            ),
                            trailing: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage()), // Ensure you import the correct DetailPage
                                );
                              },
                              child: const Text(
                                'Lihat Detail',
                                style: TextStyle(
                                  color: Color(0xFF498553),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
