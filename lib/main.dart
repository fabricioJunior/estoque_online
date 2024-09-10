import 'dart:io';

import 'package:core/datasources/hive.dart';
import 'package:flutter/material.dart';
import 'package:siv_codebar/data_access/local/dt_ultima_sync_datasource.dart';
import 'package:siv_codebar/domain/models/produto.dart';
import 'package:siv_codebar/injections.dart';
import 'package:siv_codebar/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await inicializarStorage({
    Produto: 1,
    SyncData: 2,
  });
  injections();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIV codigo de barras',
      routes: routes,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      builder: (context, widget) => widget ?? const SizedBox(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
