class Pessoa {
  final String? nome;
  final String? cpf;

  Pessoa({required this.nome, required this.cpf});

  Pessoa.fromMap(Map<String, dynamic> json)
      : nome = json['nome'],
        cpf = json['cpf'];

  Map<String, dynamic> toMap() => {
        'nome': nome,
        'cpf': cpf,
      };
}
