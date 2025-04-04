class ProdutoPedido {
  final int idPedido;
  final String descricao;
  final String tamanho;
  final String cor;
  final double preco;
  final String formaDePagamento;
  final int quantidade;

  ProdutoPedido({
    required this.idPedido,
    required this.descricao,
    required this.tamanho,
    required this.cor,
    required this.preco,
    required this.formaDePagamento,
    required this.quantidade,
  });

  ProdutoPedido copyWith({
    int? idPedido,
    String? descricao,
    String? tamanho,
    String? cor,
    double? preco,
    String? formaDePagamento,
    int? quantidade,
  }) {
    return ProdutoPedido(
      idPedido: idPedido ?? this.idPedido,
      descricao: descricao ?? this.descricao,
      tamanho: tamanho ?? this.tamanho,
      cor: cor ?? this.cor,
      preco: preco ?? this.preco,
      formaDePagamento: formaDePagamento ?? this.formaDePagamento,
      quantidade: quantidade ?? this.quantidade,
    );
  }
}

// public int pedido { get; set; }
// 		public double desconto { get; set; }
// 		public string descricao { get; set; }
// 		public string tamanho { get; set; }
// 		public string cor { get; set; }
// 		public double preco { get; set; }
// 		public string formaDePagamento { get; set; }
// 		public int quantidade { get; set; }
