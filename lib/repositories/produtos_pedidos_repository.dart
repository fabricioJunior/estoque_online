import 'package:siv_codebar/data_access/remote/pedidos_local_client.dart';
import 'package:siv_codebar/data_access/remote/produto_pedidos_remote_client.dart';
import 'package:siv_codebar/domain/models/nf_result.dart';
import 'package:siv_codebar/domain/models/pedido.dart';
import 'package:siv_codebar/domain/models/produto_pedido.dart';

class PedidosRepository {
  final ProdutoPedidosLocalClient localClient;
  final PedidosRemoteClient remoteClient;

  PedidosRepository({
    required this.localClient,
    required this.remoteClient,
  });

  Future<void> syncPedidos() async {
    var produtosPedidoLocal = await localClient.getPedidosDeHoje();
    await remoteClient.postProdutoPedido(produtosPedidoLocal);
  }

  Future<void> syncPedido(int idPedido, double desconto) async {
    var pedido = await localClient.getPedido(idPedido);
    if (desconto != 00) {
      var produtos = List<ProdutoPedido>.from(pedido.produtos);
      double total = 0;
      for (var produto in produtos) {
        pedido.produtos.remove(produto);
        total += produto.valor;
      }
      var totalComDesconto = total - desconto;
      pedido.produtos.add(ProdutoPedido(
          idPedido: idPedido,
          descricao: 'Produtos com desconto',
          tamanho: '',
          cor: '',
          valor: totalComDesconto,
          quantidade: 1,
          codigoDeBarras: '',
          desconto: desconto,
          dsrefer: 'desconto'));
    }

    await remoteClient.postProdutoPedido([pedido.toMap()]);
  }

  Future<NfResult> emitirNotaFiscalDoDia() async {
    return remoteClient.emitirNotaFiscalDoDia();
  }

  Future<NfResult> emitirNotaFiscal(int idPedido) async {
    return remoteClient.emitirNotaFiscal(idPedido);
  }

  Future<List<Pedido>> getPedidos() {
    return remoteClient.getPedidos();
  }

  Future<String> url(int idPedido) {
    return remoteClient.getUrl(idPedido);
  }
}
