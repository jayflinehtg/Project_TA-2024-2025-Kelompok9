import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  bool _isPasswordVisibleOld = false;
  bool _isPasswordVisibleNew = false;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAF4E9),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFF9ACAA1),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Nama Pengguna',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 50, 115, 63),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: _image != null ? FileImage(_image!) : null,
                child: _image == null
                    ? const Icon(Icons.person, size: 60, color: Colors.black)
                    : null,
              ),
            ),
            const SizedBox(height: 16),
            _buildReadOnlyTextField('Email'),
            _buildReadOnlyTextField('Public Key'),
            _buildFilePickerField(),
            _buildButton('Simpan', () {
              _showSnackBar('Perubahan disimpan!');
            }, 40),
            const SizedBox(height: 24),
            _buildPasswordField('Kata Sandi Lama', _isPasswordVisibleOld, () {
              setState(() {
                _isPasswordVisibleOld = !_isPasswordVisibleOld;
              });
            }),
            _buildPasswordField('Kata Sandi Baru', _isPasswordVisibleNew, () {
              setState(() {
                _isPasswordVisibleNew = !_isPasswordVisibleNew;
              });
            }),
            _buildButton('Ubah Password', () {
              _showSnackBar('Password berhasil diubah!');
            }, 40),
          ],
        ),
      ),
    );
  }

  Widget _buildReadOnlyTextField(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
        readOnly: true,
      ),
    );
  }

  Widget _buildFilePickerField() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Foto Profile',
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              readOnly: true,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: _pickImage,
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(String label, bool isVisible, VoidCallback toggleVisibility) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: TextField(
        obscureText: !isVisible,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          suffixIcon: IconButton(
            icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: toggleVisibility,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF498553),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}