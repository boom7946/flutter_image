import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class LoadImageFromDirectory extends StatefulWidget {
  const LoadImageFromDirectory({super.key});

  @override
  State<LoadImageFromDirectory> createState() => _LoadImageFromDirectoryState();
}

class _LoadImageFromDirectoryState extends State<LoadImageFromDirectory> {
  TextEditingController filename = TextEditingController();
  String? imagePath;
  bool type = true;
  List<File> _images = [];
  Future<void> loadImgefromDoc() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, 'images', filename.text);
    
    setState(() {
      imagePath = filePath;
      print(filePath);
    });
  }

  Future<void> loadImagesFromDirectory() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imageDir = Directory(path.join(directory.path, 'images'));

      if (await imageDir.exists()) {
        final List<FileSystemEntity> files = imageDir.listSync();
        setState(() {
          _images = files.whereType<File>().toList();
        });
      }
    } catch (e) {
      print('Error loading images from directory: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Load Image from Directory")),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      readOnly: type == true ? true: false,
                      decoration:const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8)))),
                      controller: filename,
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Column(
                    children: [
                      const Text("get all?"),
                      Switch(
                        value: type,
                        onChanged: (bool value) {
                          setState(() {
                            _images.clear();
                            type = value;
                          });
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  type == false ? loadImgefromDoc() : loadImagesFromDirectory();
                },
                child:const Text("getImage")),
            const SizedBox(
              height: 30,
            ),
            if (type == false) ...{
              if (imagePath != null) ...{
                Image.file(
                  File(imagePath!),
                  width: 300,
                  height: 300,
                )
              },
            } else ...{
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        _images[index],
                        width: 200,
                        height: 200,
                      ),
                    );
                  },
                ),
              ),
            }
          ],
        ),
      ),
    );
  }
}
