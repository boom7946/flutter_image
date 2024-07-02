import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_image/assetsimage.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_image/base64.dart';
import 'package:flutter_image/downloadimage.dart';
import 'package:flutter_image/loadfromdirectory.dart';

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
              SizedBox(
                child: Image.asset(
                  'assets/images/login-logo-banner.png',
                  width: 300,
                  height: 100,
                ),
              ),
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
              SizedBox(
                height: 10,
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
              SizedBox(
                height: 10,
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadImageFromDirectory()),
                  );
                },
                child: Text("Load image from Directory"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
