import 'package:http/http.dart';
import 'package:siv_codebar/data_access/remote/dtos/produto_pedido_dto.dart';
import 'package:siv_codebar/domain/models/produto_pedido.dart';

class ProdutoPedidosLocalClient {
  final String localServer;
  final Client client;

  const ProdutoPedidosLocalClient({
    required this.localServer,
    required this.client,
  });

  Future<List<ProdutoPedido>> getProdutoPedidosDeHoje() async {
    var uri = Uri.http(
      localServer,
      'produtosPedido',
    );
    var response = await client.get(uri);

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }

    return (response.body as List<dynamic>)
        .map((e) => ProdutoPedidoDto.fromJson(e))
        .toList();
  }
}
