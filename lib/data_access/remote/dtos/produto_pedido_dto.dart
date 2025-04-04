import 'package:json_annotation/json_annotation.dart';
import 'package:siv_codebar/domain/models/produto_pedido.dart';

part 'produto_pedido_dto.g.dart';

@JsonSerializable()
class ProdutoPedidoDto extends ProdutoPedido {
  ProdutoPedidoDto({
    required super.idPedido,
    required super.descricao,
    required super.tamanho,
    required super.cor,
    required super.preco,
    required super.formaDePagamento,
    required super.quantidade,
  });

  factory ProdutoPedidoDto.fromJson(Map<String, dynamic> json) =>
      _$ProdutoPedidoDtoFromJson(json);
}
