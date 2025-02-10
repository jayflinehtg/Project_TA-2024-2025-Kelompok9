import 'package:flutter/material.dart';
import 'package:project_kelompok9/login.dart';  // Ganti dengan file yang sesuai jika perlu
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
      appBar: AppBar(
        title: const Text('Jelajahi Informasi'),
        backgroundColor: const Color(0xFF9ACAA1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tanaman Herbal',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF498553),
              ),
            ),
            const SizedBox(height: 10),
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
            Expanded(
              child: ListView.builder(
                itemCount: filteredPlants.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 5,
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
                                builder: (context) => DetailPage()),
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}