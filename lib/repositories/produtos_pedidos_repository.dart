import 'package:siv_codebar/data_access/remote/produto_pedidos_local_client.dart';
import 'package:siv_codebar/data_access/remote/produto_pedidos_remote_client.dart';

class ProdutosPedidosRepository {
  final ProdutoPedidosLocalClient localClient;
  final ProdutoPedidosRemoteClient remoteClient;

  ProdutosPedidosRepository({
    required this.localClient,
    required this.remoteClient,
  });

  Future<void> syncProdutosPedido() async {
    var produtosPedidoLocal = await localClient.getProdutoPedidosDeHoje();
    await remoteClient.postProdutoPedido(produtosPedidoLocal);
  }

  Future<String> emitirNotaFiscalDoDia() async {
    return remoteClient.emitirNotaFiscalDoDia();
  }
}
