// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_pedido_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProdutoPedidoDto _$ProdutoPedidoDtoFromJson(Map<String, dynamic> json) =>
    ProdutoPedidoDto(
        idPedido: (json['idPedido'] as num).toInt(),
        descricao: json['descricao'] as String,
        tamanho: json['tamanho'] as String,
        cor: json['cor'] as String,
        valor: (json['valor'] as num).toDouble(),
        quantidade: (json['quantidade'] as num).toInt(),
        codigoDeBarras: json['codigoDeBarras'] as String,
        desconto: (json['desconto'] as num).toDouble(),
        dsrefer: (json['dsrefer']));

Map<String, dynamic> _$ProdutoPedidoDtoToJson(ProdutoPedidoDto instance) =>
    <String, dynamic>{
      'descricao': instance.descricao,
      'tamanho': instance.tamanho,
      'cor': instance.cor,
      'desconto': instance.desconto,
      'quantidade': instance.quantidade,
      'codigoDeBarras': instance.codigoDeBarras,
      'idPedido': instance.idPedido,
      'valor': instance.valor,
    };
