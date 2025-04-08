import 'package:flutter/widgets.dart';
import 'package:siv_codebar/domain/models.dart';
import 'package:siv_codebar/presentation/pages/nf_page.dart';
import 'package:siv_codebar/presentation/pages/pesquisa_produtos_page.dart';
import 'package:siv_codebar/presentation/pages/produto_page.dart';
import 'package:siv_codebar/presentation/pages/sync_status_page.dart';

Map<String, Widget Function(BuildContext)> routes = <String, WidgetBuilder>{
  '/': (context) => PesquisarProdutosPage(),
  '/sync_page': (context) => const SyncStatusPage(),
  '/produto_page': (context) => ProdutoPage(
        produto: ModalRoute.of(context)!.settings.arguments as Produto,
      ),
  '/nf_page': (context) => NfPage()
};
