import 'dart:convert';

import 'package:http/http.dart';
import 'package:siv_codebar/domain/models.dart';

class ProdutosLocalClient {
  final String localServer;
  final Client client;

  ProdutosLocalClient(this.client, this.localServer);

  Future<List<Produto>> get({
    String? busca,
    DateTime? dtUltimaAlteracao,
  }) async {
    final queryParameters = <String, String>{};
    if (busca != null) {
      queryParameters.addAll({'busca': busca});
    }
    if (dtUltimaAlteracao != null) {
      queryParameters
          .addAll({'dtUltimaAlteracao': dtUltimaAlteracao.toIso8601String()});
    }
    var uri = Uri.https(
      localServer,
      'produtos',
      queryParameters,
    );

    var response = await client.get(
      uri,
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
    return criarObjetos(response);
  }

  List<Produto> criarObjetos(Response response) {
    var decodeJson = jsonDecode(response.body);
    if (decodeJson is List<dynamic>) {
      return decodeJson
          .map<Produto>(
              (objeto) => Produto.fromJson(objeto as Map<String, dynamic>))
          .toList();
    }

    return <Produto>[];
  }
}
