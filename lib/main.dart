import 'package:flutter/material.dart';
import 'package:flutter_image/assetsimage.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_image/base64.dart';
import 'package:flutter_image/downloadimage.dart';

void main() {
  runApp(RunMyApp());
}

class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.green),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image to Base64 String'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Base64Image()),
                  );
                },
                child: Text("Base 64"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AssetsImage()),
                  );
                },
                child: Text("Assets"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DownloadImage()),
                  );
                },
                child: Text("DownloadImage"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
