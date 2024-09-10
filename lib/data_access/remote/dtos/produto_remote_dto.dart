import 'package:json_annotation/json_annotation.dart';
import 'package:siv_codebar/domain/models/produto.dart';

part 'produto_remote_dto.g.dart';

@JsonSerializable()
class ProdutoRemoteDto {
  final String descricao;
  final String referencia;
  final String tamanho;
  final String cor;
  final double valor;
  final int quantidade;
  final String codigoDeBarras;

  ProdutoRemoteDto({
    required this.descricao,
    required this.referencia,
    required this.tamanho,
    required this.cor,
    required this.valor,
    required this.quantidade,
    required this.codigoDeBarras,
  });

  factory ProdutoRemoteDto.fromJson(Map<String, dynamic> json) =>
      _$ProdutoRemoteDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProdutoRemoteDtoToJson(this);

  ProdutoRemoteDto.fromEntity(Produto produto)
      : descricao = produto.descricao,
        referencia = produto.referencia,
        tamanho = produto.tamanho,
        cor = produto.cor,
        valor = produto.valor,
        quantidade = produto.estoque,
        codigoDeBarras = produto.codigoDeBarras;

  Produto toEntity() => Produto(
        codigoDeBarras,
        '',
        tamanho,
        cor,
        quantidade,
        descricao,
        referencia,
        valor,
      );
}

extension ToDto on Produto {
  ProdutoRemoteDto toDto() => ProdutoRemoteDto(
        descricao: descricao,
        referencia: referencia,
        tamanho: tamanho,
        cor: cor,
        valor: valor,
        quantidade: estoque,
        codigoDeBarras: codigoDeBarras,
      );
}

// //{
//         "descricao": "descricao teste 1",
//         "referencia": "referencia teste 1",
//         "tamanho": "tamnho 11",
//         "cor": "cor 11",
//         "valor": 119.9,
//         "quantidade": 2,
//         "codigoDeBarras": "codigo de barra8"
//     }