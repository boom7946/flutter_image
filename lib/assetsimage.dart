import 'package:flutter/material.dart';

class AssetsImage extends StatefulWidget {
  const AssetsImage({super.key});

  @override
  State<AssetsImage> createState() => _AssetsImageState();
}

class _AssetsImageState extends State<AssetsImage> {
  String imagePath = "assets/images/";
  TextEditingController imagename = TextEditingController();
  String? images;

  void setImagePath() {
    setState(() {
      images = "$imagePath${imagename.text}.png";
      print(images);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Assets Image"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: imagename,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)))),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: setImagePath,
              child: const Text("Get Image"),
            ),
            if (images != null) 
              SizedBox(
                width: 200,
                height: 200,
                child: Image.asset(images!),
              ),
          ],
        ),
      ),
    );
  }
}
