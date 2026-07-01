import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../supabase_client.dart';

class StorageService {
  final _picker = ImagePicker();

  // GALEREYADAN RASM TANLASH
  Future<File?> pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,        // sifat 80% — hajmni kamaytiradi
      maxWidth: 1080,          // max kenglik
    );

    if (picked == null) return null;
    return File(picked.path);
  }

  // RASMNI SUPABASE'GA YUKLASH
  Future<String> uploadProductImage(File imageFile) async {
    // Unikal fayl nomi — bir xil nomlar bir-birini ezib ketmasin
    final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Storage'ga yuklash
    await supabase.storage
        .from('pakcages')        // bucket nomi
        .upload(
      fileName,              // fayl nomi
      imageFile,             // fayl
      fileOptions: const FileOptions(
        cacheControl: '3600', // 1 soat cache
        upsert: false,        // bir xil nom bo'lsa xato bersin
      ),
    );

    // Public URL olish
    final imageUrl = supabase.storage
        .from('pakcages')
        .getPublicUrl(fileName);

    return imageUrl;
  }

  //RASMNI O'CHIRISH
  Future<void> deleteProductImage(String imageUrl) async {
    // URL'dan fayl nomini ajratib olamiz
    final fileName = imageUrl.split('/').last;

    await supabase.storage
        .from('pakcages')
        .remove([fileName]);
  }
}