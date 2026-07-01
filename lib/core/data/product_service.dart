import 'package:adimin/core/supabase_client.dart';

class ProductService {
  Future<void> addPackage(
      {
        required String name,
        required String img,
        required String location_name,
        required double price,
        required double rating
      }) async{

      await supabase.from("pakcages").insert({
        "imga" :img,
         "name" :name,
          "price" : price,
          "location" : location_name,
         "rating" : rating
      });
  }
 }