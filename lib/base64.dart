import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

class Base64Image extends StatefulWidget {
  const Base64Image({super.key});

  @override
  State<Base64Image> createState() => _Base64ImageState();
}

String base64String = '';
Uint8List? bytes;

class _Base64ImageState extends State<Base64Image> {
  ImagetoBase64() async {
    // path of image
    String _imagePath = "assets/images/coffee_test2.png";
    File _imageFile = File(_imagePath);

    // Read bytes from the file object
    Uint8List _bytes = await _imageFile.readAsBytes();

    // base64 encode the bytes
    String _base64String = base64.encode(_bytes);
    setState(() {
      base64String = _base64String;
      // print(base64String);
    });
  }

  Base64ToImage() async {
    setState(() {
      bytes = Base64Codec().decode(base64String);
    });
  }

  clear() async {
    setState(() {
      base64String = "";
      bytes = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(" Base 64"),),
      body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(onPressed: () {
                  clear();
                }, child: Text("clear")),
                Container(
                  child: Image.asset('assets/images/login-logo-banner.png',width: 100,height: 100,),
                ),
                ElevatedButton(
                  onPressed: () {
                    ImagetoBase64();
                  },
                  child: Text('Convert'),
                ),
                Text(
                  base64String,
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
                ElevatedButton(onPressed: () {
                  Base64ToImage();
                }, child: Text("get Image")),
                if (bytes != null) ...{
                  
                  Container(width: 300,height: 300, child: Image.memory(bytes!),)
                  
                  
                  }
              ],
            ),
          ),
        ),
    );
  }
}
