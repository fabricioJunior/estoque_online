import 'package:json_annotation/json_annotation.dart';
part 'cor.g.dart';
@JsonSerializable()
class Cor {
  final int id;
  final String nome;

  Cor(this.id, this.nome);
}
