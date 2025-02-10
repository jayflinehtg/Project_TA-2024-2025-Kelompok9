import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class TambahDataTanamanHerbal extends StatefulWidget {
  @override
  _TambahDataTanamanHerbalState createState() => _TambahDataTanamanHerbalState();
}

class _TambahDataTanamanHerbalState extends State<TambahDataTanamanHerbal> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaTanamanController = TextEditingController();
  final TextEditingController _namaLatinController = TextEditingController();
  final TextEditingController _komposisiController = TextEditingController();
  final TextEditingController _kegunaanController = TextEditingController();
  final TextEditingController _caraPengolahanController = TextEditingController();
  File? _gambarTanaman;

  Future<void> _pilihGambar(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _gambarTanaman = File(pickedFile.path);
      });
    }
  }

  void _simpanData() {
    if (_formKey.currentState!.validate()) {
      print('Nama Tanaman: ${_namaTanamanController.text}');
      print('Nama Latin: ${_namaLatinController.text}');
      print('Komposisi: ${_komposisiController.text}');
      print('Kegunaan: ${_kegunaanController.text}');
      print('Cara Pengolahan: ${_caraPengolahanController.text}');
      print('Gambar Tanaman: ${_gambarTanaman?.path ?? 'Belum ada gambar'}');
    }
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Data Tanaman Herbal',
          style: TextStyle(
            // fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF9ACAA1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextField('Nama Tanaman Herbal', _namaTanamanController),
              _buildTextField('Nama Latin Tanaman', _namaLatinController),
              _buildTextField('Komposisi/Kandungan', _komposisiController),
              _buildTextField('Kegunaan Tanaman', _kegunaanController),
              _buildTextField('Cara Pengolahan', _caraPengolahanController),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => _pilihGambar(ImageSource.gallery),
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    image: _gambarTanaman != null
                        ? DecorationImage(image: FileImage(_gambarTanaman!), fit: BoxFit.cover)
                        : null,
                  ),
                  child: _gambarTanaman == null
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image, size: 50, color: Colors.grey),
                              Text('Pilih Gambar', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pilihGambar(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Foto'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF498553),
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pilihGambar(ImageSource.gallery),
                    icon: const Icon(Icons.image),
                    label: const Text('Galeri'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF498553),
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _simpanData,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: Color(0xFF498553),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Simpan Data', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TambahDataTanamanHerbal(),
    theme: ThemeData(primarySwatch: Colors.green),
  ));
}
