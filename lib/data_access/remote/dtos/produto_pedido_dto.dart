import 'package:json_annotation/json_annotation.dart';
import 'package:siv_codebar/domain/models/produto_pedido.dart';

part 'produto_pedido_dto.g.dart';

@JsonSerializable()
class ProdutoPedidoDto extends ProdutoPedido {
  @override
  @JsonKey(name: 'idPedido')
  // ignore: overridden_fields
  final int idPedido;

  @JsonKey(name: 'valor')
  @override
  // ignore: overridden_fields
  final double valor;

  ProdutoPedidoDto({
    required this.idPedido,
    required super.descricao,
    required super.tamanho,
    required super.cor,
    required this.valor,
    required super.quantidade,
    required super.codigoDeBarras,
    required super.desconto,
    required super.dsrefer,
  }) : super(idPedido: idPedido, valor: valor);

  factory ProdutoPedidoDto.fromJson(Map<String, dynamic> json) =>
      _$ProdutoPedidoDtoFromJson(json);
}

extension ToDto on ProdutoPedido {
  ProdutoPedidoDto toDto() => ProdutoPedidoDto(
        idPedido: idPedido,
        descricao: descricao,
        tamanho: tamanho,
        cor: cor,
        valor: valor,
        quantidade: quantidade,
        codigoDeBarras: codigoDeBarras,
        desconto: desconto,
        dsrefer: dsrefer,
      );
}
