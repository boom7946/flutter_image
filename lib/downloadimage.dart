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
    String? _imagePath;

  Future<void> downloadAndSaveImage(String imageUrl) async {
    // Get the application's documents directory
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        path.join(directory.path, 'images', 'downloaded_image.jpg');

    // Create the directory if it doesn't exist
    final imageDir = Directory(path.join(directory.path, 'images'));
    if (!await imageDir.exists()) {
      await imageDir.create(recursive: true);
    }

    // Download the image
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      // Save the image to the file
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print('Image saved to $filePath');
      setState(() {
        _imagePath = filePath;
      });
    } else {
      throw Exception('Failed to download image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () async {
            const imageUrl =
                'https://img.freepik.com/free-vector/guitar-realistic-isolated_1284-4825.jpg?t=st=1719906599~exp=1719910199~hmac=820366021b8f5c2d4fdeff44cd63ff7bd753af5fc6b04670e1aae3d8ad48d5be&w=740';
            await downloadAndSaveImage(imageUrl);
          },
          child:const Text('Download Image'),
        ),
        if (_imagePath != null) ...{
          Image.file(
            File(_imagePath!),
            width: 200,
            height: 200,
          ),

          Text("image",style: TextStyle(color: Colors.white),)
        },
      ],
    );
  }
}
