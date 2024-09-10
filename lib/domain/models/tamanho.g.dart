// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tamanho.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tamanho _$TamanhoFromJson(Map<String, dynamic> json) => Tamanho(
      (json['id'] as num).toInt(),
      json['nome'] as String,
    );

Map<String, dynamic> _$TamanhoToJson(Tamanho instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
    };
