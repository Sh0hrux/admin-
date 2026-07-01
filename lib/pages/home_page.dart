import 'package:adimin/core/data/storage_cervise.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String? selectTmage;
  final StorageService _storageService = StorageService();
  void pickImage() async{
  var file = await _storageService.pickImage();
  var imageUrl = await _storageService.uploadProductImage(file!);
  setState(() {
    selectTmage = imageUrl;
  });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Packages")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Center(
              child: GestureDetector(
                onTap: pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration:  BoxDecoration(
                    borderRadius: .circular(10),
                    border: .all(color: Colors.black),
                    color: Colors.grey
                  ),
                  child: selectTmage == null ? Icon(Icons.add_a_photo,size: 50,) :Image.network(selectTmage.toString(),fit: BoxFit.cover,),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
