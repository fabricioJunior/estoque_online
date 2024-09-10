import 'package:flutter/widgets.dart';
import 'package:siv_codebar/presentation/pages/pesquisa_produtos_page.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/': (context) => PesquisarProdutosPage()
};
