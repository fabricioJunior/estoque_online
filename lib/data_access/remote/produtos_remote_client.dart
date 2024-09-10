import 'dart:convert';

import 'package:http/http.dart';
import 'package:siv_codebar/data_access/remote/dtos/produto_remote_dto.dart';

class ProdutosRemoteClient {
  final String remoteServer;
  final Client client;

  ProdutosRemoteClient(this.client, this.remoteServer);

  Future<List<ProdutoRemoteDto>> get({
    String? busca,
    DateTime? dtUltimaAlteracao,
  }) async {
    final queryParameters = <String, String>{};

    var uri = Uri.https(
      remoteServer,
      'estoque',
      queryParameters,
    );

    var response =
        await client.get(uri, headers: {"Content-Type": "application/json"});
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception(response.body);
    }
    return criarObjetos(response);
  }

  Future<void> post(List<ProdutoRemoteDto> produtos) async {
    var uri = Uri.http(
      remoteServer,
      'estoque',
    );
    for (var produto in produtos) {
      var response = await client.post(uri,
          headers: {"Content-Type": "application/json"},
          body: getPrettyJSONString(produto));
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.body);
      }
    }
  }

  String getPrettyJSONString(jsonObject) {
    var encoder = const JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  List<ProdutoRemoteDto> criarObjetos(Response response) {
    var decodeJson = jsonDecode(response.body);
    if (decodeJson is List<dynamic>) {
      return decodeJson
          .map<ProdutoRemoteDto>((objeto) =>
              ProdutoRemoteDto.fromJson(objeto as Map<String, dynamic>))
          .toList();
    }

    return <ProdutoRemoteDto>[];
  }
}
