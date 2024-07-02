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
    int _imageCount = 0;
  Future<void> downloadAndSaveImage(String imageUrl) async {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'downloaded_image_${_imageCount ++}.jpg';
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
    return Scaffold(
      appBar: AppBar(title: Text("Download Image & get Image from Directory")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                const imageUrl =
                    'https://cdn-imgix.headout.com/tour/12449/TOUR-IMAGE/d40f6e72-a95b-4043-b85d-e065093828d8-6871-dubai-img-worlds-of-adventure-vip-experience-03.jpg?auto=format&w=713.0666666666667&h=458.4&q=90&ar=14%3A9&crop=faces';
                await downloadAndSaveImage(imageUrl);
              },
              child:const Text('Download Image'),
            ),
            SizedBox(height: 20,),
            if (_imagePath != null) ...{
              Image.file(
                File(_imagePath!),
                width: 200,
                height: 200,
              ),
        
              Text("image",style: TextStyle(color: Colors.white),)
            },
          ],
        ),
      ),
    );
  }
}
