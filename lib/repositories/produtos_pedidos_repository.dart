import 'package:siv_codebar/data_access/remote/produto_pedidos_local_client.dart';
import 'package:siv_codebar/data_access/remote/produto_pedidos_remote_client.dart';
import 'package:siv_codebar/domain/models/nf_result.dart';

class ProdutosPedidosRepository {
  final ProdutoPedidosLocalClient localClient;
  final PedidosRemoteClient remoteClient;

  ProdutosPedidosRepository({
    required this.localClient,
    required this.remoteClient,
  });

  Future<void> syncProdutosPedido() async {
    var produtosPedidoLocal = await localClient.getProdutoPedidosDeHoje();
    await remoteClient.postProdutoPedido(produtosPedidoLocal);
  }

  Future<NfResult> emitirNotaFiscalDoDia() async {
    return remoteClient.emitirNotaFiscalDoDia();
  }

  Future<NfResult> emitirNotaFiscal(int idPedido) async {
    return remoteClient.emitirNotaFiscal(idPedido);
  }
}
