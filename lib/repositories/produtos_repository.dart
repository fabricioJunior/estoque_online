import 'package:siv_codebar/data_access/local/dt_ultima_sync_datasource.dart';
import 'package:siv_codebar/data_access/local/produtos_local_datasource.dart';
import 'package:siv_codebar/data_access/remote/dtos/produto_remote_dto.dart';
import 'package:siv_codebar/data_access/remote/produtos_local_client.dart';
import 'package:siv_codebar/data_access/remote/produtos_remote_client.dart';

import '../domain/models.dart';

class ProdutosRepository {
  final ProdutosLocalClient produtosClient;
  final ProdutosRemoteClient produtosRemoteClient;
  final DtUltimaSyncDatasource dtUltimaSyncDatasource;
  final ProdutosLocalDatasource produtosLocalDatasource;

  ProdutosRepository(
    this.produtosClient,
    this.produtosRemoteClient,
    this.produtosLocalDatasource,
    this.dtUltimaSyncDatasource,
  );

  Future<List<Produto>> buscaProdutosDoServidor(String busca) async {
    var produtos = await produtosLocalDatasource.fetchAll();
    return produtos.toList();
  }

  Future<Iterable<Produto>> buscaTodosProdutos() async {
    var produtos = await produtosLocalDatasource.fetchAll();

    return produtos;
  }

  Future<Iterable<Produto>> buscaProdutos(String busca) async {
    var produtos = await produtosLocalDatasource.fetchAll();
    var produtosFiltrados = produtos
        .where((produto) =>
            produto.descricao.toUpperCase().contains(busca.toUpperCase()) ||
            produto.cor.toUpperCase().contains(busca))
        .toList();
    produtosFiltrados.sort((a, b) => a.estoque.compareTo(b.estoque));
    return produtosFiltrados;
  }

  Future<void> syncServeData() async {
    var dtUltimaAlteracao = await dtUltimaSyncDatasource.fetch(
      'produtos_serve',
    );
    var allProdutos = await produtosClient.get(
      dtUltimaAlteracao: dtUltimaAlteracao?.data,
    );
    await produtosRemoteClient.post(
      allProdutos.map((e) => e.toDto()).toList(),
    );
    await dtUltimaSyncDatasource.put(
      SyncData(
        nome: 'produtos_serve',
        data: DateTime.now(),
      ),
    );
  }

  Future<void> syncLocalData() async {
    var dtUltimaAlteracao = await dtUltimaSyncDatasource.fetch('produtos');
    var allProdutos = await produtosRemoteClient.get(
        dtUltimaAlteracao: dtUltimaAlteracao?.data);
    await produtosLocalDatasource.putAll(allProdutos.map((e) => e.toEntity()));
    await dtUltimaSyncDatasource.put(SyncData(
      nome: 'produtos',
      data: DateTime.now(),
    ));
  }
}
