import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  int _imageCount = 0;
  Future<void> downloadAndSaveImage(String imageUrl) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = 'downloaded_image_${_imageCount++}.jpg';
    final filePath = path.join(directory.path, 'images', fileName);

    final imageDir = Directory(path.join(directory.path, 'images'));
    if (!await imageDir.exists()) {
      await imageDir.create(recursive: true);
    }

    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      print('Image saved to $filePath');
      setState(() {
        _imagePath = filePath;
        print(_imagePath);
      });
    } else {
      throw Exception('Failed to download image');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController imageURL = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: Text("Download Image & get Image from Directory")),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)))),
                controller: imageURL,
              ),
            ),
          ),
          SizedBox( height: 10,),
          ElevatedButton(
            onPressed: () async {
              String imageUrl =imageURL.text;
              await downloadAndSaveImage(imageUrl);
            },
            child: const Text('Download Image'),
          ),
          const SizedBox(
            height: 20,
          ),
          if (_imagePath != null) ...{
            Image.file(
              File(_imagePath!),
              width: 200,
              height: 200,
            ),
            const Text(
              "image",
              style: TextStyle(color: Colors.white),
            )
          },
        ],
      ),
    );
  }
}
