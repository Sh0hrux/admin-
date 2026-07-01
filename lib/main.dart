import 'package:adimin/core/supabase_client.dart';
import 'package:adimin/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://fqxpuvxoifchwzyjchrq.supabase.co',
    anonKey: 'sb_publishable_IO1bsXm4uTLk6dlbJN9K6A_PTM7fXZ-',
  );

  // Agar sessiya mavjud bo'lmasa, login qilishga harakat qilamiz
  if (supabase.auth.currentSession == null) {
    try {
      await supabase.auth.signInWithPassword(
        email: "example@gmail.com", // gail.com -> gmail.com bo'lishi kerak edi (typo)
        password: "12345678",
      );
    } catch (e) {
      debugPrint('Login xatosi: $e');
      // xato bo'lsa ham ilova ochilishi kerak
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}