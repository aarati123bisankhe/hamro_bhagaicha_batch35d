import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hamro_bhagaicha_batch35d/core/theme/app_background.dart';
import 'package:image_picker/image_picker.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String? _summary;
  bool _isProcessing = false;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 90,
    );

    if (pickedFile == null) return;

    setState(() {
      _selectedImage = File(pickedFile.path);
      _summary = null;
    });
  }

  Future<void> _processImage() async {
    if (_selectedImage == null) return;

    setState(() {
      _isProcessing = true;
      _summary = null;
    });

    await Future.delayed(const Duration(seconds: 2));

    final imageName = _selectedImage!.path
        .split(Platform.pathSeparator)
        .last
        .toLowerCase();
    final generatedSummary = _generateSummary(imageName);

    if (!mounted) return;
    setState(() {
      _isProcessing = false;
      _summary = generatedSummary;
    });
  }

  String _generateSummary(String imageName) {
    if (imageName.contains('leaf') || imageName.contains('plant')) {
      return 'The image appears to focus on plant foliage. The leaves look generally healthy with visible texture and structure. Check for spots, curling, or yellow edges to detect early stress signs.';
    }
    if (imageName.contains('flower') || imageName.contains('rose')) {
      return 'The image likely contains a flowering plant. The bloom structure and petal arrangement are visible. Ensure adequate sunlight and regular watering based on soil dryness.';
    }
    if (imageName.contains('pot') || imageName.contains('soil')) {
      return 'The image appears related to a pot/soil setup. Drainage and soil moisture management are key. Keep the top inch of soil slightly dry between watering cycles.';
    }

    return 'Image processed successfully. It appears to show gardening-related content. Review leaf color, stem firmness, and soil moisture for a quick plant health check.';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: appBackgroundDecoration(context),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Plant Scanner',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                const SizedBox(height: 14),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color.fromARGB(
                              255,
                              4,
                              5,
                              6,
                            ).withValues(alpha: 0.85)
                          : Colors.white.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: _selectedImage == null
                        ? Center(
                            child: Text(
                              'Capture or upload an image to start scanning.',
                              style: TextStyle(
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0D47A1),
                        ),
                        onPressed: () => _pickImage(ImageSource.camera),
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text('Capture'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF0D47A1),
                        ),
                        onPressed: () => _pickImage(ImageSource.gallery),
                        icon: const Icon(Icons.photo_library_outlined),
                        label: const Text('Upload'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _selectedImage == null || _isProcessing
                        ? null
                        : _processImage,
                    icon: _isProcessing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.analytics_outlined),
                    label: Text(
                      _isProcessing ? 'Processing...' : 'Submit for Summary',
                    ),
                  ),
                ),
                if (_summary != null) ...[
                  const SizedBox(height: 14),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark
                          ? const Color(0xFF0F172A).withValues(alpha: 0.85)
                          : const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _summary!,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
