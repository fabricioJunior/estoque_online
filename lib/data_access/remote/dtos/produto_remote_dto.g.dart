// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_remote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProdutoRemoteDto _$ProdutoRemoteDtoFromJson(Map<String, dynamic> json) =>
    ProdutoRemoteDto(
      descricao: json['descricao'] as String,
      referencia: json['referencia'] as String,
      tamanho: json['tamanho'] as String,
      cor: json['cor'] as String,
      valor: (json['valor'] as num).toDouble(),
      quantidade: (json['quantidade'] as num).toInt(),
      codigoDeBarras: json['codigoDeBarras'] as String,
    );

Map<String, dynamic> _$ProdutoRemoteDtoToJson(ProdutoRemoteDto instance) =>
    <String, dynamic>{
      'descricao': instance.descricao,
      'referencia': instance.referencia,
      'tamanho': instance.tamanho,
      'cor': instance.cor,
      'valor': instance.valor,
      'quantidade': instance.quantidade,
      'codigoDeBarras': instance.codigoDeBarras,
    };
