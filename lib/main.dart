import 'package:flutter/material.dart';
import 'package:news_test/src/app/views/app.dart';
import 'package:news_test/src/infra/services/storage_service.dart';
import 'package:news_test/src/utils/loader_service.dart';
LoaderService loader = LoaderService.instance;
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  await StorageService.initialize();
  runApp(const NewsApp());
}
