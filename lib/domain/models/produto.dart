import 'package:core/datasources/local_dtos.dart';
import 'package:json_annotation/json_annotation.dart';

part 'produto.g.dart';

@JsonSerializable()
class Produto extends StorageEntity {
  final String codigoDeBarras;
  final String codigoReduzido;
  final String tamanho;
  final String cor;
  final int estoque;
  final String descricao;
  final String referencia;
  @JsonKey(defaultValue: 0)
  final double valor;

  Produto(
    this.codigoDeBarras,
    this.codigoReduzido,
    this.tamanho,
    this.cor,
    this.estoque,
    this.descricao,
    this.referencia,
    this.valor,
  );

  factory Produto.fromJson(Map<String, dynamic> json) =>
      _$ProdutoFromJson(json);

  @override
  Map<String, dynamic> get storageProperties => {
        'codigoDeBarras': codigoDeBarras,
        'codigoReduzido': codigoReduzido,
        'tamanho': tamanho,
        'cor': cor,
        'estoque': estoque,
        'descricao': descricao,
        'referencia': referencia,
      };
}
