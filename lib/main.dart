import 'dart:io';

import 'package:core/datasources/hive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:siv_codebar/data_access/local/dt_ultima_sync_datasource.dart';
import 'package:siv_codebar/domain/models/produto.dart';
import 'package:siv_codebar/injections.dart';
import 'package:siv_codebar/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //HttpOverrides.global = MyHttpOverrides();
  Bloc.observer = MyBlocObserve();
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
      initialRoute: initialRoute(),
      builder: (context, widget) => widget ?? const SizedBox(),
    );
  }

  String initialRoute() {
    return '/';

    if (kIsWeb) {}
    if (Platform.isWindows || Platform.isMacOS) {
      return '/sync_page';
    }

    return '/';
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

class MyBlocObserve extends BlocObserver {
  final Logger logger = Logger();
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    logger.i('erro:', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
