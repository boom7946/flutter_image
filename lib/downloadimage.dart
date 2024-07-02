import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class DownloadImage extends StatefulWidget {
  const DownloadImage({super.key});

  @override
  State<DownloadImage> createState() => _DownloadImageState();
}

class _DownloadImageState extends State<DownloadImage> {
  Future<void> downloadAndSaveImage(String imageUrl) async {
    // Get the application's documents directory
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, 'downloaded_image.jpg');

    // Download the image
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      // Save the image to the file
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print('Image saved to $filePath');
    } else {
      throw Exception('Failed to download image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        const imageUrl =
            'https://img.freepik.com/free-vector/red-rooster-cock-side-view-abstract_1284-16627.jpg?t=st=1719904396~exp=1719907996~hmac=0397348cd9210dd2fd2b48c5e597a14739b7d2a2570260e7bbb378014bfb12e0&w=740';
        await downloadAndSaveImage(imageUrl);
      },
      child: Text('Download Image'),
    );
  }
}
