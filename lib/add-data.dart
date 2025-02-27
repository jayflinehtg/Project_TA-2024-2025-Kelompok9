import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tambah Data Tanaman',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AddPlantForm(),
    );
  }
}

class AddPlantForm extends StatefulWidget {
  @override
  _AddPlantFormState createState() => _AddPlantFormState();
}

class _AddPlantFormState extends State<AddPlantForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _plantNameController = TextEditingController();
  TextEditingController _latinNameController = TextEditingController();
  TextEditingController _compositionController = TextEditingController();
  TextEditingController _benefitController = TextEditingController();
  TextEditingController _processingController = TextEditingController();
  XFile? _imageFile;
  Uint8List? _imageBytes;

  List<String> _compositionList = [];
  List<String> _benefitList = [];
  List<String> _processingList = [];

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _imageFile = image;
        _imageBytes = bytes;
      });
    }
  }

  void _addToField(String value, List<String> list) {
    setState(() {
      list.add(value);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tambah Data',
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
                  const SizedBox(height: 4),
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
            // Form section
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTextField('Nama Tanaman', _plantNameController),
                      _buildTextField('Nama Latin Tanaman', _latinNameController),
                      _buildTextFieldMultiLine('Komposisi/Kandungan', _compositionController, _compositionList),
                      _buildTextFieldMultiLine('Manfaat Tanaman', _benefitController, _benefitList),
                      _buildTextFieldMultiLine('Cara Pengolahan', _processingController, _processingList),

                      SizedBox(height: 16),
                      Text('Gambar Tanaman',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF498553))),
                      SizedBox(height: 8),

                      if (_imageBytes != null)
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                _imageBytes!,
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: 8),
                          ],
                        ),

                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        icon: Icon(Icons.image, color: Colors.white),
                        label: Text('Pilih Gambar', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        ),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Data berhasil disimpan!'),
                              ));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[700],
                          ),
                          child: Text('Simpan', style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF498553))),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: 'Masukkan $label',
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildTextFieldMultiLine(String label, TextEditingController controller, List<String> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF498553))),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(),
            hintText: 'Masukkan $label',
          ),
          maxLines: 5,
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              _addToField(value, list);
              controller.clear();
            }
          },
        ),
        SizedBox(height: 16),
      ],
    );
  }
}