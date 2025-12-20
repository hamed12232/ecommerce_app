import 'package:ecommerce_app/app.dart';
import 'package:ecommerce_app/core/di/service_locator.dart';
import 'package:ecommerce_app/core/utils/helper/network_manager.dart';
import 'package:ecommerce_app/core/utils/services/shared_pref.dart';
import 'package:ecommerce_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  NetworkManager.instance.onInit();
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://icbtdurswywzkffoxzqs.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImljYnRkdXJzd3l3emtmZm94enFzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjYyMTgyNjUsImV4cCI6MjA4MTc5NDI2NX0.XHUamSqRV2FRVxsVXR-UD47AUZJ6pAys_MNbDdfxKvs',
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefServices.init();
  await setupServiceLocator();
  runApp(const App());
}
