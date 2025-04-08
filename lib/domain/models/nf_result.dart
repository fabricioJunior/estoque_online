class NfResult {
  final double total;

  final List<String> nfs;

  NfResult({required this.total, required this.nfs});

  NfResult.fromJson(Map<String, dynamic> json)
      : total = double.parse(json['totalEmitido'].toString()),
        nfs =
            (json['danfes'] as List<dynamic>).map((e) => e as String).toList();
}
