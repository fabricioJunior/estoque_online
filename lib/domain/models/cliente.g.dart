// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cliente _$ClienteFromJson(Map<String, dynamic> json) => Cliente(
      id: (json['id'] as num).toInt(),
      nome: json['nome'] as String,
      cpf: json['cpf'] as String,
      rg: json['rg'] as String,
      sexo: json['sexo'] as String,
    );

Map<String, dynamic> _$ClienteToJson(Cliente instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'cpf': instance.cpf,
      'rg': instance.rg,
      'sexo': instance.sexo,
    };
